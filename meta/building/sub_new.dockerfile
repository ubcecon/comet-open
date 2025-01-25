#This file will act as the build stage, along with this all package versions will be listed. 
FROM rocker/tidyverse:4.2.2 as builder

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl=7.74.0-1.3+deb11u7 \
    gdebi-core=0.9.5.7+nmu3 \
    libgl1=1.3.2-1 \
    libglx-mesa0=20.3.5-1 \
    libxt6=1:1.2.0-1 \
    python3-pip=20.3.4-4+deb11u1 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Python packages
RUN python3 -m pip install --break-system-packages jupyter==1.0.0

# Install Quarto
RUN curl -LO https://github.com/quarto-dev/quarto-cli/releases/download/v1.3.450/quarto-1.3.450-linux-amd64.deb \
    && gdebi -n quarto-1.3.450-linux-amd64.deb \
    && rm quarto-1.3.450-linux-amd64.deb

# Install R packages
RUN install2.r --error renv@0.17.3 stargazer@5.2.3 \
    && Rscript -e 'install.packages(c("xfun", "vctrs", "rmarkdown", "tidyverse", "knitr", "IRkernel"), repos="https://cran.rstudio.com/", version=c("0.39", "0.6.3", "2.22", "2.0.0", "1.43", "1.3.2"))'

# Verify Quarto installation
RUN quarto check
