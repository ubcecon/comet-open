# Contributing and Building the COMET Pages

The COMET homepage is built automatically, using a GitLab pages deployment, and a standard [JupyterBook configuration](https://jupyterbook.org/en/stable/intro.html).  This repository is organized as follows:

* in the main root directory are all of the project-level files, such as `README.md` and the `.yml` files which run the deployment pipeline
  * `.gitlab-ci.yml` contains the configuration for the jobs which builds the website and deploy it using Kubernetes
  * If you have developer permissions, the actual URL configuration for the website is under Settings > Pages on GitLab
  * To display the web-page, you need to run _deploy_ manually
* All of the project files are in `comet-home`, which is the directory which contains the built files, configuration, and content
  * `_config.yml` and `_toc.yml` are the main configuration files.  They configure the JupyterBook (`config`) and organize it (`toc`)
  * All of the actual content is in `docs`
  * The built website is in `_build`.  

```{Tip}
You should not edit or create files in the `_build` folder manually.  All content can be changed by editing the files in `doc` or the configuration files.
```

If you don't have maintainer or owner access, you will need to submit the `push` actions below using a `merge` request instead.

## Updating Existing Content

To update existing content, overwrite the updated files, then submit a `git push` to the `pages` branch.  It will build automatically.

* You can check the build status under _Jobs_ on Gitlab

It's a good idea to check the _build_ job log to see if there are any warnings or errors created.  These usually indicate formatting problems.

To finally push to the web page, run the _deploy_ stage manually.

## Adding New Content

To add new content, start by adding it on GitLab.  On the `pages` branch:

* First, add the new content to the `docs` directory, in an appropriate sub-directory.
* Second, update `_toc.yml` to include the new files in the built website.  Files which are not included in the table of contents are _not_ built.
* When you are done adding your content, submit a `git push` to the `pages` branch to build the website

```{warning}
Do not push your commits until you are ready to build the new page.  It will build automatically and uses server resources (bad!).
```

As with updating content, check the _build_ log for warnings or errors.

* To finally push to the web page, run the _deploy_ stage manually.

### Tips for Specific Content

* When adding Notebooks (`.ipynb`) make sure you clear all output to reduce file size or selectively run parts of the notebooks as needed.

## Removing Content

To remove content, repeat the two-step procedure to add content in reverse, then run _deploy_.
