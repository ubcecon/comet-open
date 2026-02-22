#!/usr/bin/env python3
"""
One-time setup script to configure all COMET .qmd notebooks for the rendered pattern.
This script:
1. Modifies YAML headers in all .qmd files in docs/ to add self-contained settings
2. Creates stub .qmd files for each notebook
3. Generates _quarto.yml exclusion lines
4. Generates _quarto.yml sidebar replacement mappings
5. Generates .dockerfile lines
"""

import re
import sys
from pathlib import Path


def parse_yaml_header(content: str) -> tuple[str, str]:
    """Extract YAML header and body from a .qmd file."""
    match = re.match(r'^---\s*\n(.*?)\n---\s*\n?(.*)', content, re.DOTALL)
    if not match:
        return "", content
    return match.group(1), match.group(2)


def extract_metadata(yaml_content: str) -> dict:
    """Extract title, date, description, categories from YAML header."""
    metadata = {}

    # Title
    m = re.search(r'^title:\s*["\']?(.*?)["\']?\s*$', yaml_content, re.MULTILINE)
    if m:
        metadata['title'] = m.group(1).strip().strip("'\"")

    # Date
    m = re.search(r'^date:\s*["\']?(.*?)["\']?\s*$', yaml_content, re.MULTILINE)
    if m:
        metadata['date'] = m.group(1).strip().strip("'\"")

    # Description - can be multi-line
    m = re.search(r'^description:\s*(.*?)(?=\n\w|\n---|\Z)', yaml_content, re.MULTILINE | re.DOTALL)
    if m:
        desc = m.group(1).strip().strip("'\"")
        # Clean up multi-line descriptions
        desc = re.sub(r'\s+', ' ', desc).strip()
        metadata['description'] = desc

    # Categories
    m = re.search(r'^categories:\s*\[(.*?)\]', yaml_content, re.MULTILINE)
    if m:
        metadata['categories'] = m.group(1).strip()

    return metadata


def get_kernelspec_block(yaml_content: str) -> str:
    """Extract the kernelspec/ipynb format block from YAML."""
    # Find the ipynb section
    lines = yaml_content.split('\n')
    in_ipynb = False
    ipynb_lines = []
    ipynb_indent = 0

    for i, line in enumerate(lines):
        stripped = line.strip()
        if stripped.startswith('ipynb:'):
            in_ipynb = True
            ipynb_indent = len(line) - len(line.lstrip())
            ipynb_lines.append(line)
            continue

        if in_ipynb:
            current_indent = len(line) - len(line.lstrip()) if line.strip() else ipynb_indent + 1
            if current_indent > ipynb_indent or not line.strip():
                ipynb_lines.append(line)
            else:
                break

    if ipynb_lines:
        return '\n'.join(ipynb_lines)
    return ""


def modify_yaml_header(yaml_content: str) -> str:
    """Modify YAML header to add self-contained settings."""
    lines = yaml_content.split('\n')
    new_lines = []

    # Track what we've seen
    seen_execute = False
    seen_format = False
    skip_until_next_top_level = False
    skip_section = None

    # Collect the ipynb block
    ipynb_block = get_kernelspec_block(yaml_content)

    for i, line in enumerate(lines):
        stripped = line.strip()

        # Skip execute block if it exists (we'll replace it)
        if stripped.startswith('execute:'):
            seen_execute = True
            skip_section = 'execute'
            continue

        # Skip format block if it exists (we'll replace it)
        if stripped.startswith('format:'):
            seen_format = True
            skip_section = 'format'
            continue

        # If we're skipping a section, check if we've reached a new top-level key
        if skip_section:
            if line and not line[0].isspace() and stripped and not stripped.startswith('-'):
                skip_section = None
                # Don't skip this line - it's a new section
            else:
                continue

        new_lines.append(line)

    # Build the new header
    result_lines = new_lines.copy()

    # Add execute block
    result_lines.append('execute:')
    result_lines.append('  eval: true')
    result_lines.append('  echo: true')
    result_lines.append('  output: true')

    # Add format block
    result_lines.append('format:')
    result_lines.append('  html:')
    result_lines.append('    embed-resources: true')
    result_lines.append('    self-contained-math: true')

    if ipynb_block:
        result_lines.append('  ' + ipynb_block.lstrip())
    else:
        # Default R kernel
        result_lines.append('  ipynb:')
        result_lines.append('    jupyter:')
        result_lines.append('      kernelspec:')
        result_lines.append('        display_name: R')
        result_lines.append('        language: r')
        result_lines.append('        name: ir')

    return '\n'.join(result_lines)


def create_stub_content(metadata: dict, original_filename: str) -> str:
    """Create a stub .qmd file that redirects to the rendered HTML."""
    html_filename = original_filename.replace('.qmd', '.html')

    lines = ['---']

    if 'title' in metadata:
        # Escape quotes in title
        title = metadata['title'].replace('"', '\\"')
        lines.append(f'title: "{title}"')

    if 'date' in metadata:
        lines.append(f'date: {metadata["date"]}')

    if 'description' in metadata:
        desc = metadata['description'].replace('"', '\\"')
        lines.append(f'description: "{desc}"')

    if 'categories' in metadata:
        lines.append(f'categories: [{metadata["categories"]}]')

    lines.append('---')
    lines.append('')
    lines.append(f'<meta http-equiv="refresh" content="0; url={html_filename}">')
    lines.append('')
    lines.append(f'If you are not redirected automatically, [click here]({html_filename}).')
    lines.append('')

    return '\n'.join(lines)


def main():
    repo_root = Path(__file__).resolve().parent.parent.parent
    project_root = repo_root / 'project'
    docs_root = project_root / 'docs'

    if not docs_root.exists():
        print(f"Error: docs directory not found at {docs_root}")
        sys.exit(1)

    # Find all .qmd files in docs/
    qmd_files = sorted(docs_root.rglob('*.qmd'))

    # Filter out any existing stub files
    qmd_files = [f for f in qmd_files if '_stub' not in f.name]

    print(f"Found {len(qmd_files)} .qmd notebook files")
    print()

    exclusion_lines = []
    sidebar_mappings = []
    dockerfile_rm_lines = []
    dockerfile_copy_lines = []
    modified_count = 0
    stub_count = 0

    for qmd_path in qmd_files:
        rel_path = qmd_path.relative_to(project_root)
        rel_path_posix = rel_path.as_posix()
        filename = qmd_path.name
        stem = qmd_path.stem

        print(f"Processing: {rel_path_posix}")

        # Read the file
        content = qmd_path.read_text(encoding='utf-8')
        yaml_header, body = parse_yaml_header(content)

        if not yaml_header:
            print(f"  WARNING: No YAML header found, skipping")
            continue

        # Extract metadata for stub
        metadata = extract_metadata(yaml_header)

        # Modify YAML header
        new_yaml = modify_yaml_header(yaml_header)
        new_content = f"---\n{new_yaml}\n---\n{body}"
        qmd_path.write_text(new_content, encoding='utf-8')
        modified_count += 1

        # Create stub file
        stub_filename = f"{stem}_stub.qmd"
        stub_path = qmd_path.parent / stub_filename
        stub_content = create_stub_content(metadata, filename)
        stub_path.write_text(stub_content, encoding='utf-8')
        stub_count += 1

        # Generate exclusion line
        exclusion_lines.append(f'  - "!{rel_path_posix}"')

        # Generate sidebar mapping
        stub_rel_path = rel_path_posix.replace('.qmd', '_stub.qmd')
        sidebar_mappings.append((rel_path_posix, stub_rel_path))

        # Generate dockerfile lines
        dockerfile_rm_lines.append(f"RUN rm -f ./{rel_path_posix}")
        html_rel_path = rel_path_posix.replace('.qmd', '.html')
        parent_dir = str(rel_path.parent).replace('\\', '/')
        dockerfile_copy_lines.append(
            f"COPY ./project/{html_rel_path} /app/output/{parent_dir}/"
        )

    print()
    print(f"Modified {modified_count} .qmd files")
    print(f"Created {stub_count} stub files")

    # Write exclusion lines to a file for easy copy-paste
    output_dir = repo_root / 'meta' / 'scripts'
    output_dir.mkdir(parents=True, exist_ok=True)

    exclusions_file = output_dir / 'generated_exclusions.txt'
    exclusions_file.write_text('\n'.join(exclusion_lines) + '\n', encoding='utf-8')
    print(f"Wrote exclusion lines to: {exclusions_file}")

    sidebar_file = output_dir / 'generated_sidebar_mappings.txt'
    sidebar_content = '\n'.join(
        f"{old} -> {new}" for old, new in sidebar_mappings
    )
    sidebar_file.write_text(sidebar_content + '\n', encoding='utf-8')
    print(f"Wrote sidebar mappings to: {sidebar_file}")

    dockerfile_file = output_dir / 'generated_dockerfile_lines.txt'
    df_content = "# Remove rendered .qmd files\n"
    df_content += '\n'.join(dockerfile_rm_lines)
    df_content += '\n\n# Copy pre-rendered HTML files\n'
    df_content += '\n'.join(dockerfile_copy_lines)
    dockerfile_file.write_text(df_content + '\n', encoding='utf-8')
    print(f"Wrote dockerfile lines to: {dockerfile_file}")

    print()
    print("NEXT STEPS:")
    print("1. Copy exclusion lines from generated_exclusions.txt into _quarto.yml render section")
    print("2. Update sidebar references in _quarto.yml (use generated_sidebar_mappings.txt)")
    print("3. Update .dockerfile (use generated_dockerfile_lines.txt)")


if __name__ == '__main__':
    main()
