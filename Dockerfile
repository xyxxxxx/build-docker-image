FROM pytorch/pytorch:2.4.0-cuda12.1-cudnn9-runtime

RUN apt-get update && \
  apt-get install -yq --no-install-recommends openssh-server pdsh git && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

RUN git clone --depth 1 https://github.com/hiyouga/LLaMA-Factory.git && \
  cd LLaMA-Factory && \
  pip install --no-cache-dir --upgrade pip && \
  pip install -e ".[torch,metrics,deepspeed,bitsandbytes]" && \
  cd .. && \
  rm -rf LLaMA-Factory

RUN mkdir /run/sshd
RUN chown root:root /usr/lib

WORKDIR /workspace
