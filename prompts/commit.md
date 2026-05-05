---
name: Commit message
interaction: chat
description: Generate a Conventional Commit message
opts:
  alias: commit2
  auto_submit: false
  is_slash_cmd: true
---

## user

You are an expert at following the Conventional Commits specification strictly. Given the git diff listed below, generate a single commit message that:

### Format Requirements

1. **Exactly follow the Conventional Commits specification** with the format:
   ```
   <type>[optional scope]: <description>
   [optional body]
   [optional footer(s)]
   ```

2. Types MUST be one of: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`, `revert`

3. **BREAKING CHANGES**: If present, the footer MUST start with `BREAKING CHANGE:`, and `!` MUST be appended after the type/scope (e.g., `feat!:` or `feat(api)!:`)

4. Description MUST be:
   - In lowercase
   - NOT end with a period
   - Start with an imperative verb (e.g., "add", "fix", "update", "remove")
   - Concise, ideally under 72 characters

5. Scope: Include in parentheses after the type if clearly evident from the diff

6. Body (if the diff contains multiple logical changes):
   - Explain WHAT changed and WHY, not HOW
   - Use a bulleted list with `-` as the marker
   - Each bullet point MUST be wrapped at 72 characters
   - If a bullet point spans multiple lines, indent continuation lines with 2 spaces
   - Separate from description by exactly one blank line

7. Footer: Separate from body (or description if no body) by exactly one blank line

### Output Format

You MUST output ONLY the commit message, wrapped in exactly FOUR BACKTICKS on their own lines. Nothing else — no preamble, no explanation, no commentary.

### Git Diff

`````diff
${commit.diff}
`````

