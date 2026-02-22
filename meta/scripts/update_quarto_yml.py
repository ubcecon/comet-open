#!/usr/bin/env python3
"""
Update _quarto.yml with exclusion lines and sidebar stub references.
"""

import re
from pathlib import Path


def main():
    repo_root = Path(__file__).resolve().parent.parent.parent
    quarto_yml = repo_root / 'project' / '_quarto.yml'
    exclusions_file = repo_root / 'meta' / 'scripts' / 'generated_exclusions.txt'

    content = quarto_yml.read_text(encoding='utf-8')
    exclusions = exclusions_file.read_text(encoding='utf-8').strip()

    # Step 1: Add exclusion lines after the existing render section entries
    # Find the render section and add exclusions after "!in_progress/*"
    content = content.replace(
        '  - "!in_progress/*"\n',
        '  - "!in_progress/*"\n' + exclusions + '\n'
    )

    # Step 2: Update sidebar file references from .qmd to _stub.qmd
    # Only for docs/ paths (not pages/ paths)
    # Match patterns like: file: docs/...something.qmd
    def replace_sidebar_ref(match):
        prefix = match.group(1)
        path = match.group(2)
        # Only replace docs/ paths, not pages/ paths
        if path.startswith('docs/') and '_stub.qmd' not in path:
            # Replace .qmd with _stub.qmd
            new_path = path.replace('.qmd', '_stub.qmd')
            return f'{prefix}{new_path}'
        return match.group(0)

    content = re.sub(
        r'(file:\s*)(docs/[^\s#]+\.qmd)',
        replace_sidebar_ref,
        content
    )

    quarto_yml.write_text(content, encoding='utf-8')
    print("Updated _quarto.yml with exclusions and sidebar stub references")

    # Verify
    exclusion_count = content.count('"!docs/')
    stub_count = content.count('_stub.qmd')
    print(f"  Exclusion lines: {exclusion_count}")
    print(f"  Stub references: {stub_count}")


if __name__ == '__main__':
    main()
