FROM lengyue233/fish-speech:latest

ENV HF_ENDPOINT=https://hf-mirror.com
ENV GRADIO_SERVER_NAME=0.0.0.0
COPY webui.py /exp/tools/webui.py
RUN python -m tools.webui --exit

ENTRYPOINT [ "python", "-m", "tools.webui" ]
