FROM yanwk/comfyui-boot:cu124-cn-20241021

RUN cd /root && \
  chmod +x /runner-scripts/download.sh && \
  bash /runner-scripts/download.sh && \
  mv /root/* /home

COPY entrypoint.sh /runner-scripts/entrypoint.sh
