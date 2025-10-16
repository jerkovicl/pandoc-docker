#FROM haskell:8.10
FROM haskell:9.12.2

# will ease up the update process
# updating this env variable will trigger the automatic build of the Docker image
# ENV PANDOC_VERSION "2.11.1"
ENV PANDOC_VERSION "3.8.2" 

# install pandoc
RUN cabal update && cabal install pandoc-${PANDOC_VERSION}

# update /etc/apt/sources.list to stretch distribution
RUN echo "deb http://ftp.us.debian.org/debian/ stretch main contrib non-free" | tee -a /etc/apt/sources.list
RUN echo "deb-src http://ftp.us.debian.org/debian/ stretch main contrib non-free" | tee -a /etc/apt/sources.list

# install latex packages
RUN apt-get update -y \
  && apt-get install -y --no-install-recommends --fix-missing \
    texlive-full \
    fontconfig \
    curl

WORKDIR /source
