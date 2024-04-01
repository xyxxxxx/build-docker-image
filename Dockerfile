FROM teojgo/nccl-tests:cuda12.3

RUN apt-get update && \
  apt-get install -yq --no-install-recommends openssh-server && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*
RUN mkdir /run/sshd
