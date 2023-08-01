# Developing on the Project

This project has two main development tools:

1.  Quarto, and the associated Quarto Markdown `.qmd` format
2.  Jupyter, and the associated `.ipynb` format

In general, for notebook modules which have `.qmd` files you should **always develop using Quarto** not Jupyter.  To produce `.ipynb` output and test, render your notebook to `.ipynb` instead.

## Using Quarto

Quarto is much easier to use than Jupyter.  To use Quarto:

1.  Install R and RStudio for your operating system, following the [guide](https://posit.co/download/rstudio-desktop/)
2.  Install Git: <https://git-scm.com/book/en/v2/Getting-Started-Installing-Git>
3.  Install Quarto: <https://quarto.org/docs/get-started/> and then follow the tutorial for RStudio

Clone the repository and get coding.

## Jupyter Configuration

For this project, if you are using Jupyter notebooks they should run on UBC's JupyterOpen environment.  You can access and develop via a JupyterHub, which can be found at:

<https://lthub.ubc.ca/guides/jupyterhub-instructor-guide/>

You should log in using your CWL.  This **does not support** STATA development.  You should install Jupyter locally, following the instructions in the STATA modules to develop in STATA.

> ***Package Caveats***:  note that the `stargazer`, `car`, `estimater` and `sandwich` packages are not installed on the PIMS server.  You will need to install these manually; we recommend using the terminal if this fails.  This issue will not occur when we transfer to the UBC Open Server.

## It's not working!

If you can't connect to the hub, or it keeps failing, try the following steps, retrying the JupyterHub after each step:

1.  If the kernel is running, shut it down, then restart your notebook.
2.  Close your browser (entirely) then re-open the hub, then go to step 1.
3.  Clear your cookies, try again, then go to step 2.
4.  Reboot your PC, try again, then go to step 3.

If these do not resolve the issue, contact <jonathan.graves@ubc.ca> with a description of the issue.  

* Ensure you clearly identify the issue, and outline the steps you took to resolve it before contacting support.

## Kernel Configuration (To be Confirmed)

When you are working on the hub, we use the following kernels:

- R (`irkernel`) kernel version: 1.3
    + R version 4.1.2
- Python (`ipykernel`) kernel version: 6.13.0
    + Python version 3.9.7
    + iPython 7.31.0

# Home Jupyter Set-up

It is also possible to develop locally, in Jupyter.  You can find instructions on the project website:

* <https://comet.arts.ubc.ca/pages/installing_locally.html>


