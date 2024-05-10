FROM t9kpublic/stable-diffusion-webui:aki-v4.8-semi

ENV DEBIAN_FRONTEND=noninteractive

ENV NB_PREFIX=/

SHELL ["/bin/bash", "-c"]

RUN apt-get update && apt-get install -yq --no-install-recommends \
  ffmpeg \
  libsm6 \
  libxext6 \
  git \
  && apt-get clean && \
  rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir --upgrade pip && \
  pip install --no-cache-dir --default-timeout=100 -r requirements_versions.txt
RUN python launch.py --exit --skip-torch-cuda-test

ENTRYPOINT [ "./launch.sh" ]
