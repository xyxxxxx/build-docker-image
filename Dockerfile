FROM pytorch/pytorch:2.2.0-cuda11.8-cudnn8-runtime

RUN apt-get update && \
  apt-get install -yq --no-install-recommends git && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/allenai/OLMo.git && \
  cd OLMo && \
  pip install -e .[all] && \
  rm -rf OLMo
