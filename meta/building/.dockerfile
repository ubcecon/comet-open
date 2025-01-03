FROM rocker/tidyverse:latest as builder

WORKDIR /app

COPY ./meta/building/renv.lock ./project ./

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl gdebi-core libgl1 libglx-mesa0 libxt6 \
    && python3 -m pip install --include-deps jupyter \
    && curl -LO https://quarto.org/download/latest/quarto-linux-amd64.deb \
    && gdebi -n quarto-linux-amd64.deb \
    && rm quarto-linux-amd64.deb \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && install2.r --error renv stargazer \
    && Rscript -e 'install.packages(c("xfun", "vctrs", "rmarkdown", "tidyverse", "knitr", "IRkernel"))' \
    && mkdir output \
    && quarto check \
    && quarto render --output-dir output

FROM scratch
COPY --from=builder /app/output /
