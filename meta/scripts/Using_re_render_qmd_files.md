# Re-render Self-Contained QMD Files

This script automates the process of re-rendering `.qmd` files that need to be self-contained HTML files for the COMET website.

## Background

Some notebooks in COMET require packages and datasets that are not available in the Docker build environment. These files are:
- Excluded from the Docker build (listed in `_quarto.yml` with `!` prefix)
- Rendered locally as self-contained HTML files
- The HTML is copied alongside the source `.qmd` for deployment

## Prerequisites

1. **Quarto** must be installed and available in your PATH
   - Verify installation: `quarto --version`

2. **Python 3.9+** is required

3. **Required packages** for the notebooks you're rendering must be installed locally
   - Each notebook may have different requirements (check the notebook headers)
   - The dataset also has to be present in the correct directory

## Usage

### Basic Usage

Run:

```bash
# Navigate to the repository first
cd D:\GitHub\comet-open
python meta\scripts\re_render_qmd_files.py
```

### Options

| Option | Description |
|--------|-------------|
| `--dry-run` | Show what would be done without actually rendering |
| `--file FILTER` | Only render files matching the filter (partial match) |
| `--verbose, -v` | Show detailed output |

### Examples

```bash
# Preview what files would be rendered
python re_render_qmd_files.py --dry-run

# Render only specific files
python re_render_qmd_files.py --file intro_to_r

# Render with verbose output
python re_render_qmd_files.py --verbose
```

## How It Works

1. **Discovery**: Parses `project/_quarto.yml` to find files excluded from the build (lines with `!` prefix)

2. **Verification**: Checks that each file has the required self-contained headers:
   ```yaml
   execute:
     eval: true
     echo: true
     output: true
   format:
     html:
       embed-resources: true
       self-contained-math: true
   ```

3. **Rendering**: For each file:
   - Runs `quarto render FILENAME.qmd` from the project directory
   - The HTML is generated in `project/_site/docs/...`
   - Copies the HTML to `project/docs/...` (same directory as source)

4. **Reporting**: Provides a summary showing successful and failed renders

5. While running the script has a detailed output showing which cell it is on and the status of rendering and executing. Very useful for debugging notebooks which do not want to render.

## Troubleshooting

### "Quarto is not installed or not in PATH"
Install Quarto from https://quarto.org/docs/get-started/

### Render fails with package errors
Make sure you have all required Python/R packages installed locally. Check the notebook's first cells for package requirements.

### HTML not found after rendering
- Ensure you're running from the repository root
- Check the Quarto output for errors
- Verify the file has correct headers

### Missing required headers warning
The file needs the self-contained headers shown above. Either:
- Add the headers to the file

## Adding New Files

To add a new file for local rendering:

1. Add self-contained headers to the `.qmd` file (see above)

2. Add exclusion to `project/_quarto.yml`:
   ```yaml
   render:
     - "!docs/YOUR-SECTION/your_file.qmd"
   ```

3. Add to `meta/building/.dockerfile`:
   ```dockerfile
   RUN rm -f ./docs/YOUR-SECTION/your_file.qmd
   COPY ./project/docs/YOUR-SECTION/your_file.html /app/output/docs/YOUR-SECTION/
   ```

4. Create a stub file `your_file_stub.qmd`:
   ```yaml
   ---
   title: Your Title
   # ... other metadata ...
   ---

   <meta http-equiv="refresh" content="0; url=your_file.html">

   If you are not redirected automatically, [click here](your_file.html).
   ```

5. Update the sidebar in `_quarto.yml` to use the stub instead of the original

6. Run this script to render the HTML locally
