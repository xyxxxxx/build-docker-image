# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
# Copy from https://github.com/kubeflow/kubeflow/blob/v0.7.0/components/tensorflow-notebook-image/Dockerfile

FROM continuumio/miniconda3:23.9.0-0

USER root

ENV DEBIAN_FRONTEND=noninteractive
ENV NB_PREFIX=/

# Use bash instead of sh
SHELL ["/bin/bash", "-c"]

RUN apt-get update && apt-get install -yq --no-install-recommends \
  apt-transport-https \
  build-essential \
  # comment for already installed
  # bzip2 \
  # ca-certificates \
  curl \
  emacs \
  g++ \
  # git \
  gnupg \
  graphviz \
  htop \
  locales \
  lsb-release \
  # openssh-client \
  openssh-server \
  rsync \
  s3cmd \
  sudo \
  unzip \
  vim \
  # wget \
  zip \
  && apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# Install Nodejs for jupyterlab-manager
RUN curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
RUN apt-get update && apt-get install -yq --no-install-recommends \
  nodejs \
  && apt-get clean && \
  rm -rf /var/lib/apt/lists/*

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
  locale-gen
ENV LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8
ENV SHELL=/bin/bash

# NOTE: Beyond this point be careful of breaking out
# or otherwise adding new layers with RUN, chown, etc.
# The image size can grow significantly.

RUN pip uninstall enum34 -y

# unset http proxy, pip3 --proxy="" doesn't work
ENV http_proxy= \
    HTTP_PROXY= \
    https_proxy= \
    HTTPS_PROXY=

# Install base python packages
RUN pip install --no-cache-dir -i https://pypi.tuna.tsinghua.edu.cn/simple --upgrade pip && \
  pip install --no-cache-dir -i https://pypi.tuna.tsinghua.edu.cn/simple --default-timeout=100 \
    h5py==3.10.0 \
    ipywidgets==8.1.1 \
    jupyter==1.0.0 \
    jupyterlab==4.0.7 \
    jupyterlab-widgets==3.0.9 \
    jupyterlab-language-pack-zh-CN==4.0.post3

ARG GID=1000
ARG UID=1000
RUN groupadd --gid=$GID t9kuser && mkdir /t9k && \
  useradd -rm --create-home -d /t9k/mnt --shell /bin/bash \
  --uid=$UID --gid=$GID t9kuser

# https://unix.stackexchange.com/questions/4484/ssh-prompts-for-password-despite-ssh-copy-id
# sshd has strict requirements about permissions on $HOME, $HOME/.ssh
RUN chmod 755 /t9k/mnt
WORKDIR /t9k/mnt

# TODO: User should be refactored instead of hard coded t9kuser

COPY bashrc-conda /etc/bash.bashrc
