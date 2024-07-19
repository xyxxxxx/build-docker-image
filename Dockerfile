FROM lengyue233/fish-speech:latest

ENV HF_ENDPOINT=https://hf-mirror.com
ENV GRADIO_SERVER_NAME=0.0.0.0
RUN huggingface-cli download fishaudio/fish-speech-1.2-sft --local-dir checkpoints/fish-speech-1.2-sft
