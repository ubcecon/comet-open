# TLEF Project: Developing interactive learning modules for hands-on-econometrics skills

_(We need a cooler title)_

Welcome to the repository for our large TLEF project.  This site stores our materials for developing Jupyter-based notebooks to support teaching introductory and intermediate econometrics courses.  This project is funded by the University of British Columbia.  The motivating "pitch" is as follows:

> Currently, all economics students take several courses in the application of economic theory and models to data using statistical methods (econometrics).  Many students struggle to engage with this material, particularly when it comes to practical applications and hands-on experience – putting them at a disadvantage following graduation or in more advanced courses.
>This project will address this challenge by creating a collection of hands-on modules designed around best practices for teaching statistics.  These modules, focused on economic questions, models, and data, will use interactive notebook-based technologies (Jupyter) to synthesize analysis, discussion, and conceptualization into a single learning experience – appropriate for either laboratory or flipped classroom instruction.
>By adapting proven pedagogical strategies and integrating this material throughout the economics curriculum, students will better master these valuable skills.  This project will also improve accessibility, by lowering costs and hardware requirements, and will produce a library of open educational resources for broader instructional needs.

You can find details about this project here, in addition to the key files and formats.  By contributing to this project, you agree to our project code of conduct.

## Important Documents

You can find the most important documents here, in our repository:

- The `CODE_OF_CONDUCT.md` file contains our project and repository code of conduct, which is expected that all members and contributors follow.
- The `JUPYTER.md` file contains details on the Jupyter (and JupyterHub) configuration, either if you are connecting to the cloud-based hub or setting up a local server with the same properties.
- The `LICENSE` file contains our project's open-source license.

All of the other documentation is on our project Wiki, which you should refer to for things such as Style Guides, Documentation, and other material.

# Repository Guidelines

## Repository Commit Guidelines

It is very important that you follow these guidelines when committing work to the repository, in order to keep things well-organized.

There are two special branches: `main` and `pages`.

- `main` is the current "completed" set of modules or units, ready for deployment.
- `pages` is a special branch which is reserved for website deployment.

1.  Do **not** commit to either `pages` or `main` without specific guidance to do so.  Always change these branches through a merge request instead.
2.  Keep each _new_ module or unit on its own branch: when you start working on a new module, create a new branch of `main` to store your work with a descriptive name.  Don't use an existing branch for a new modules.
3.  When you are finished a module, create a merge request for it back to main, and delete the old branch if you don't need it.

Ensure that you keep your commits clean and tidy:

- Use a descriptive commit title and description
- Make sure you have removed temporary files and other materials

Any commits or merge requests that do not meet these guidelines will be rejected and will need to be re-done.

## Large Files Commit Guidelines
_(As of April 2022)_

Large files are problematic in Git: because they are stored as binaries _any_ change to them (including inconsequential ones) creates a new version of the file, which is then stored in the repository's commit history.  This means that the repo can quickly balloon in size to an unmanagable degree.  We are currently exploring the use of the [git Large File Storage](https://git-lfs.github.com/) system, but we are not 100% sure if things are working yet.

- Please place all large data files in a the [dedicated  UBC OneDrive folder](https://ubcca-my.sharepoint.com/:f:/g/personal/jonathan_graves_ubc_ca/Ei9qKd8LviRAgJ5QRWBBDXwB4Bg5CRobsOxhOhGDhu8rag?e=0NrpP4) and copy the files to your notebook directory as-needed.
  + Create an issue to have the file managed by the LFS server and tag a maintainer.  You can remove the file form the OneDrive folder once it is under version control.
- This applies to files such as: (i) raw data, (ii) datasets, (iii) videos, (iv) large images.  Anything roughly larger than 10 mb should be considered "large" for the purposes of this repository

Currently, the list of filetypes which should be automatically version controlled can be viewed in the `.gitattributes` file in the main repository.


