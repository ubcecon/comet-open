FROM rocker/tidyverse:latest as RBase

RUN install2.r --error \
    renv \ 
    stargazer

COPY renv.lock /app/renv.lock
RUN  R -e 'renv::restore()'



RUN apt-get update --fix-missing && apt-get -y install curl \
    && apt-get -y install gdebi-core \
    && apt-get -y install libgl1-mesa-glx\
    && apt-get install -y libxt6 \
    && curl -LO https://quarto.org/download/latest/quarto-linux-amd64.deb \
    && gdebi -n quarto-linux-amd64.deb

COPY comet-quarto /app
WORKDIR /app
RUN mkdir output
RUN quarto check 
RUN quarto render --output-dir output

# install.packages(c("xfun", "vctrs", "rmarkdown", "tidyverse"))

FROM ghcr.io/openfaas/of-watchdog:0.9.6 AS watchdog
FROM alpine:latest

RUN mkdir /app
COPY --from=RBase /app/output /app
COPY --from=watchdog /fwatchdog .

ENV mode="static"
ENV static_path="/app"

HEALTHCHECK --interval=3s CMD [ -e /tmp/.lock ] || exit 1

CMD ["./fwatchdog"]