FROM rocker/rstudio:latest

## allow root access to terminal in RStudio
ENV ROOT=TRUE
ENV PASSWORD=password
ENV DISABLE_AUTH=TRUE

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    libgit2-dev \
    libxml2-dev \
    libcairo2-dev \
    liblapack-dev \
    liblapack3 \
    libopenblas-base \
    libopenblas-dev \
    libpq-dev \
    default-jdk \
    libbz2-dev \
    libicu-dev \
    liblzma-dev \
    libv8-dev \
    openssh-client \
    mdbtools \
    libmagick++-dev \
    libsnappy-dev \
    autoconf \
    automake \
    libtool \
    python-dev \
    pkg-config \
    p7zip-full \
    libzmq3-dev \
  && rm -rf -- /var/lib/apt/lists /tmp/*.deb

RUN install2.r --error \
    --deps TRUE \
    devtools

## add regularly used packages
RUN install2.r --error \
  RcppEigen \
  lme4 \
  car \
  scales \
  reshape2 \
  RPostgreSQL \
  Hmisc \
  scales \
  zoo \
  futile.logger \
  caTools \
  writexl \
  feather \
  drake \
  visNetwork \
  clustermq \
  secret \
  XLConnect \
  && R -e 'remotes::install_gitlab("thedatacollective/segmentr")' \
  && R -e 'remotes::install_gitlab("thedatacollective/typothemes")' \
  && R -e 'remotes::install_github("StevenMMortimer/salesforcer")' \
  && rm -rf /tmp/downloaded_packages/ \
  && rm -rf /tmp/*.tar.gz

## Add /data volume by default
VOLUME /data
VOLUME /home/rstudio/.ssh
