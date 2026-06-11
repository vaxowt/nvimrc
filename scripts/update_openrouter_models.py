#!/usr/bin/env python3
"""Fetch ranked free models from OpenRouter and update ai.lua."""

import argparse
import json
import re
import sys
import urllib.error
import urllib.request
from pathlib import Path

NUM_MODELS = 20
API_URL = 'https://openrouter.ai/api/v1/models?sort=most-popular'
REQUEST_TIMEOUT = 15


def fetch_models():
    """Fetch models from OpenRouter API. Returns (all_models, top_free_ids)."""
    req = urllib.request.Request(
        API_URL,
        headers={'User-Agent': 'neovim-config/1.0 (update-openrouter-models)'},
    )
    try:
        resp = urllib.request.urlopen(req, timeout=REQUEST_TIMEOUT)
    except urllib.error.URLError as e:
        print(f'Network error: {e.reason}')
        sys.exit(1)
    except OSError as e:
        print(f'Request failed: {e}')
        sys.exit(1)

    try:
        body = json.load(resp)
    except json.JSONDecodeError as e:
        print(f'Invalid JSON response: {e}')
        sys.exit(1)

    data = body.get('data')
    if not isinstance(data, list):
        print(
            f'Unexpected API response: "data" is {type(data).__name__}, expected list'
        )
        sys.exit(1)

    all_models = {}
    for m in data:
        mid = m.get('id')
        pricing = m.get('pricing')
        if not mid or not isinstance(pricing, dict):
            continue
        all_models[mid] = m

    free = [
        m for m in data if m.get('pricing', {}).get('prompt') == '0'
        and m.get('pricing', {}).get('completion') == '0' and m.get('id')
    ]
    top_free = [m['id'] for m in free[:NUM_MODELS]]

    if not top_free:
        print('No free models found')
        sys.exit(0)

    return all_models, top_free


def find_section(lines, marker, start=0):
    """Find the first line containing *marker*, starting from *start*."""
    for i in range(start, len(lines)):
        if marker in lines[i]:
            return i
    return None


def find_brace_end(lines, start):
    """Find the line that closes the brace block starting at *start*.

    Assumes no unmatched braces inside Lua strings or comments within the
    target block (valid for the known structure of ai.lua).
    """
    depth = lines[start].count('{') - lines[start].count('}')
    i = start
    while depth > 0:
        i += 1
        if i >= len(lines):
            raise RuntimeError(
                'Unmatched opening brace — malformed Lua block?')
        depth += lines[i].count('{') - lines[i].count('}')
    return i


def extract_value(line):
    """Extract the value from a `key = 'value'` line using a single-quoted string."""
    m = re.search(r"'([^']+)'", line)
    return m.group(1) if m else None


def strip_indent(line):
    """Return the leading whitespace of *line*."""
    return line[:len(line) - len(line.lstrip())]


def compute_diff(old_list, new_list):
    """Return (added, removed) model ids."""
    old_set, new_set = set(old_list), set(new_list)
    return sorted(new_set - old_set), sorted(old_set - new_set)


def main():
    parser = argparse.ArgumentParser(
        description='Update ai.lua with top free OpenRouter models')
    parser.add_argument(
        '--dry-run',
        action='store_true',
        help='Show changes without writing to file',
    )
    args = parser.parse_args()

    repo_root = Path(__file__).resolve().parents[1]
    ai_lua = repo_root / 'lua' / 'plugins' / 'ai.lua'

    all_models, top_free = fetch_models()

    def is_valid_free(model_id):
        m = all_models.get(model_id)
        return bool(m and m.get('pricing', {}).get('prompt') == '0'
                    and m.get('pricing', {}).get('completion') == '0')

    try:
        with open(ai_lua) as f:
            lines = f.readlines()
    except OSError as e:
        print(f'Failed to read {ai_lua}: {e}')
        sys.exit(1)

    openrouter_idx = find_section(lines, "name = 'openrouter'")
    if openrouter_idx is None:
        print('openrouter adapter not found')
        sys.exit(1)

    choices_idx = find_section(lines, 'choices = {', start=openrouter_idx)
    if choices_idx is None:
        print('choices block not found in openrouter adapter')
        sys.exit(1)

    try:
        end_idx = find_brace_end(lines, choices_idx)
    except RuntimeError as e:
        print(e)
        sys.exit(1)

    # Read current default model
    default_old = None
    for i in range(openrouter_idx, choices_idx):
        if 'default = ' in lines[i]:
            default_old = extract_value(lines[i])
            break

    # Read old model list for diff
    old_models = []
    for i in range(choices_idx + 1, end_idx):
        v = extract_value(lines[i])
        if v:
            old_models.append(v)

    # Build the final choices list
    if default_old and default_old not in top_free and is_valid_free(
            default_old):
        choices_list = [default_old] + top_free
        default_new = default_old
    else:
        choices_list = list(top_free)
        if default_old and default_old in top_free:
            default_new = default_old
        else:
            default_new = top_free[0]

    # Build new choices block (preserve original indentation)
    indent = strip_indent(lines[choices_idx])
    item_indent = indent + '    '
    close_indent = strip_indent(lines[end_idx])

    new_block = [f"{indent}choices = {{\n"]
    for m in choices_list:
        new_block.append(f"{item_indent}'{m}',\n")
    new_block.append(f"{close_indent}}},\n")

    new_lines = lines[:choices_idx] + new_block + lines[end_idx + 1:]

    if default_new != default_old:
        for i in range(openrouter_idx, choices_idx):
            if 'default = ' in new_lines[i]:
                dindent = strip_indent(new_lines[i])
                new_lines[i] = f"{dindent}default = '{default_new}',\n"
                break

    if lines == new_lines:
        print('Already up to date')
        return

    # Print summary
    print(f'Default: {default_new}', end='')
    if default_old is None:
        print(' (newly set)')
    elif default_old != default_new:
        print(f' (was {default_old})')
    else:
        print(' (preserved)')

    n = len(choices_list)
    print(f'Choices ({n} models):')
    for m in choices_list:
        marker = ' (default)' if m == default_new else ''
        print(f'  {m}{marker}')

    added, removed = compute_diff(old_models, choices_list)
    if added:
        print('Added:')
        for m in added:
            print(f'  + {m}')
    if removed:
        print('Removed:')
        for m in removed:
            print(f'  - {m}')

    if args.dry_run:
        print('Dry-run — file not written')
        return

    try:
        with open(ai_lua, 'w') as f:
            f.writelines(new_lines)
    except OSError as e:
        print(f'Failed to write {ai_lua}: {e}')
        sys.exit(1)

    print('File updated')


if __name__ == '__main__':
    main()
