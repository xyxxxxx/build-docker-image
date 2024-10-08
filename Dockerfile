FROM lengyue233/fish-speech:latest

RUN huggingface-cli download fishaudio/fish-speech-1.4 --local-dir checkpoints/fish-speech-1.4
COPY webui.py /opt/fish-speech/tools/webui.py
RUN python -m tools.webui --exit --device cpu

ENV GRADIO_SERVER_NAME=0.0.0.0
ENTRYPOINT [ "python", "-m", "tools.webui" ]
