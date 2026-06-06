#!/usr/bin/env python3
"""Fetch ranked free models from OpenRouter and update ai.lua."""

import json
import sys
import urllib.request
from pathlib import Path

NUM_MODELS = 20

REPO_ROOT = Path(__file__).resolve().parents[1]
AI_LUA = REPO_ROOT / 'lua' / 'plugins' / 'ai.lua'

req = urllib.request.Request(
    'https://openrouter.ai/api/v1/models',
    headers={'User-Agent': 'update-openrouter-models/1.0'},
)
resp = urllib.request.urlopen(req)
data = json.load(resp)['data']

# Build a lookup for all models (id -> model)
all_models = {m['id']: m for m in data}

free = sorted(
    [
        m for m in data
        if m['pricing']['prompt'] == '0' and m['pricing']['completion'] == '0'
    ],
    key=lambda m: m['created'],
    reverse=True,
)
top_free = [m['id'] for m in free[:NUM_MODELS]]

if not top_free:
    print('No free models found')
    sys.exit(0)


# A model is "valid" if it exists in the API and is free
def is_valid_free(model_id):
    m = all_models.get(model_id)
    return m and m['pricing']['prompt'] == '0' and m['pricing'][
        'completion'] == '0'


with open(AI_LUA) as f:
    lines = f.readlines()

# Locate openrouter adapter
openrouter_idx = None
for i, line in enumerate(lines):
    if "name = 'openrouter'" in line:
        openrouter_idx = i
        break

assert openrouter_idx is not None, 'openrouter adapter not found'

# Locate choices = { after openrouter
choices_idx = None
for i in range(openrouter_idx, len(lines)):
    if 'choices = {' in lines[i]:
        choices_idx = i
        break

assert choices_idx is not None, 'choices block not found in openrouter adapter'

# Find closing brace via brace-depth counting
depth = lines[choices_idx].count('{') - lines[choices_idx].count('}')
end_idx = choices_idx
while depth > 0 and end_idx < len(lines) - 1:
    end_idx += 1
    depth += lines[end_idx].count('{') - lines[end_idx].count('}')

# Read current default model
default_old = None
for i in range(openrouter_idx, choices_idx):
    if 'default = ' in lines[i]:
        default_old = lines[i].split("'")[1]
        break

# Build the final choices list
if default_old and default_old not in top_free and is_valid_free(default_old):
    choices_list = [default_old] + top_free
    default_new = default_old
else:
    choices_list = list(top_free)
    if default_old and default_old in top_free:
        default_new = default_old
    else:
        default_new = top_free[0]

# Build new choices block (preserve original indentation)
indent = lines[choices_idx][:len(lines[choices_idx]) -
                            len(lines[choices_idx].lstrip())]
item_indent = indent + '    '
close_indent = lines[end_idx][:len(lines[end_idx]) -
                              len(lines[end_idx].lstrip())]

new_block = [f"{indent}choices = {{\n"]
for m in choices_list:
    new_block.append(f"{item_indent}'{m}',\n")
new_block.append(f"{close_indent}}},\n")

new_lines = lines[:choices_idx] + new_block + lines[end_idx + 1:]

if default_new != default_old:
    for i in range(openrouter_idx, choices_idx):
        if 'default = ' in new_lines[i]:
            dindent = new_lines[i][:len(new_lines[i]) -
                                   len(new_lines[i].lstrip())]
            new_lines[i] = f"{dindent}default = '{default_new}',\n"
            break

if lines != new_lines:
    with open(AI_LUA, 'w') as f:
        f.writelines(new_lines)
    if default_old is None:
        print(f'Default set to {default_new}')
    elif default_old != default_new:
        print(f'Default changed: {default_old} -> {default_new}')
    else:
        print(f'Default preserved: {default_new}')
    n = len(choices_list)
    print(f'Choices ({n} models):')
    for m in choices_list:
        marker = ' (default)' if m == default_new else ''
        print(f'  {m}{marker}')
else:
    print('Already up to date')
