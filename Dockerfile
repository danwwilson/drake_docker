FROM thedatacollective/rstudio_preview:latest

## allow root access to terminal in RStudio
ENV ROOT=TRUE
ENV PASSWORD=password
ENV DISABLE_AUTH=TRUE
ENV TZ=Australia/Brisbane

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
    openssh-client \
    mdbtools \
    libsnappy-dev \
    autoconf \
    automake \
    libtool \
    python-dev \
    pkg-config \
    p7zip-full \
    libudunits2-dev \
    tzdata \
  && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
  && dpkg-reconfigure -f noninteractive tzdata
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
  officer \
  flextable \
  xaringan \
  ggthemes \
  futile.logger \
  dplyr \
  readxl \
  writexl \
  drake \
  extrafont \
  visNetwork \
  clustermq \
  secret \
  XLConnect \
  fst \
  && R -e 'remotes::install_gitlab("thedatacollective/segmentr")' \
  && R -e 'remotes::install_github("wilkelab/gridtext")' \
  && R -e 'remotes::install_github("danwwilson/hrbrthemes", "dollar_axes")' \
  && R -e 'remotes::install_github("thedatacollective/tdcthemes")' \
  && R -e 'remotes::install_gitlab("thedatacollective/templatermd")' \
  && R -e 'remotes::install_github("StevenMMortimer/salesforcer")' \
  && R -e 'remotes::install_github("milesmcbain/fnmate")' \
  && R -e 'remotes::install_github("gaborcsardi/dotenv")' \
  && R -e 'install.packages("data.table", type = "source", repos = "http://Rdatatable.github.io/data.table")' \
  && rm -rf /tmp/downloaded_packages/ \
  && rm -rf /tmp/*.tar.gz

## Add /data volume by default
VOLUME /data
VOLUME /home/rstudio/.ssh