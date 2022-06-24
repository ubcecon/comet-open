# Jupyter Configuration

> ***Important:*** we are initially starting development using the PIMS Syzygy JupyterHub, which is somewhat limited in capabilities.  By the end of May, we will transition to the UBC Open JupyterHub, so this information will change. 

For this project, we will be using Jupyter notebooks.  You can access and develop via a JupyterHub, which can be found at:

<https://ubc.syzygy.ca/>

You should log in using your CWL.  We recommend, in general, that you should develop on the cloud-based hub unless that is impossible.  We also recommend using JupyterLab to develop and JupyterNotebook to test or debug.

> ***Package Caveats***:  note that the `stargazer`, `car`, `estimater` and `sandwich` packages are not installed on the PIMS server.  You will need to install these manually; we recommend using the terminal if this fails.  This issue will not occur when we transfer to the UBC Open Server.

## It's not working!

If you can't connect to the hub, or it keeps failing, try the following steps, retrying the JupyterHub after each step:

1.  If the kernel is running, shut it down, then restart your notebook.
2.  Close your browser (entirely) then re-open the hub, then go to step 1.
3.  Clear your cookies, try again, then go to step 2.
4.  Reboot your PC, try again, then go to step 3.

If these do not resolve the issue, contact <jonathan.graves@ubc.ca> with a description of the issue.  

- Ensure you clearly identify the issue, and outline the steps you took to resolve it before contacting support.

## Kernel Configuration (To be Confirmed)

When you are working on the hub, we use the following kernels:

- R (`irkernel`) kernel version: 1.3
    + R version 4.1.2
- Python (`ipykernel`) kernel version: 6.13.0
    + Python version 3.9.7
    + iPython 7.31.0

# Home Jupyter Set-up

It is also possible to develop locally, if you do not wish to use the server (e.g. you don't have an internet connection).  To do use, you should ensure you have the same kernel version, and the following standard libraries installed:

- (To be confirmed with CTLT/IT)

We strongly recommend installing Python and Jupyter via the Anaconda distribution (or its lightweight cousin, Miniconda).  You can find some tutorials for this process here:

- [Installing Anaconda](https://docs.anaconda.com/anaconda/install/index.html)
- [Installing Miniconda](https://docs.conda.io/en/latest/miniconda.html)
- [Installing Jupyter](https://jupyter.org/install) and [JupyterLab](https://jupyterlab.readthedocs.io/en/stable/getting_started/installation.html)
- [Installing R into Anaconda](https://docs.anaconda.com/anaconda/user-guide/tasks/using-r-language/)
- Installing the `irkernel`: [official documentation](https://irkernel.github.io/installation/), [JupyterLab documentation](https://richpauloo.github.io/2018-05-16-Installing-the-R-kernel-in-Jupyter-Lab/)

After you have installed Jupyter, install the associated packages (above).  You will need administrator access on your computer to do this successfully.  



