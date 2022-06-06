# Jupyter Notebooks Using Stata

In this folder you will find everything you need to review and prepare a project for ECON490. The files found here will follow this structure:

1. Basic Stata Review : Working around Do-files
2. Data Management using Stata
3. Graphs using Stata
4. Statistical Analysis: Descriptive and Regression Analysis
5. Template ECON490 Project using Stata

Before we begin this journey, we need to set-up your workspace to be able to run Jupyter notebooks along with Stata. To do so, you need to install the latest [Anaconda version](https://www.anaconda.com/).

## What is Anaconda? 

Conda is an open-source package and environment management system. With Conda we can create a particular directory folder (also known as environment) that will contain the packages that allows us to run Jupyter online notebooks that run code coming from different softwares (henceforth referred as kernels): Stata, R, Python, etc. The bare minimum that any environment needs to have is some Python version. 

## Setting up your local Stata

Once Anaconda has been downloaded you may run the Anaconda3 Command Prompt. This works pretty much like any other terminal (e.g. Windows Powershell), but will recognize the command `conda`. 

Conda can find some packages to install from channels, which you may think of as some server to download stuff from. The channel that we want to make sure that our computer will find first is the `conda-forge` channel. To allow this you should run the following:

```
  conda config --add channels conda-forge
  conda config --set channel_priority strict
```

The goal here is to create a package bundle, i.e. an environment, where we will install some version of R, Stata Kernel, and Jupyter. You can explore the things we can download to an environment from the  `conda-forge` channel by running, for example, `conda search r-base`, `conda search stata_kernel`. You can see that the terminal lists all the different versions of these packages that we can download from the different channels. 

Great, now we are ready to create a new environment where we will install all these packages. In this particular case, we will create an environment based on Python 3.9.7. Let us create an environment called `stata_r_env` by writing:

```
  conda create -n stata_r_env python=3.9.7
```

If you ommit the `=3.9.7` part, you will create an environment with the default Python version. We want anything that we install from the channel to be part of this new environment. To do so, we need to activate it by running
```
  conda activate stata_r_env
```

Now that our environment is activated we can install everything we want. We begin by installing Jupyter, which will allow us to run the interactive notebooks:

```
  conda install jupyter
```

Next, we install the Stata Kernel by running:

```  
  conda install -c conda-forge stata_kernel
  python -m stata_kernel.install
```

Finally, to be able to run the entire ECON 490 folder, it is highly recommended to install a stable R-version. In this particular case, we will focus on R 4.1.2. To install this we type

```  
  conda install -c conda-forge r-base=4.1.2  
```

To use R interactively from this environment we need to open R from the terminal. If you use Windows you can type `r.exe` or `start r`, and if you use MacOS you may type `r`. You will notice that there is a message like when we open R from our desktop, you need to run
```  
  install.packages('IRkernel')
  IRkernel::installspec()
  q()
```

The first two lines connect our R version with the Jupyter notebook, and the last line closes R from the terminal because we're done. Now you should be able to change directory from the terminal by running `cd any_directory` and then running `jupyter notebook` to open the interactive webpage to open, create and export Jupyter notebooks. 

