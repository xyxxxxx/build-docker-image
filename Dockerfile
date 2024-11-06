FROM significantgravitas/auto-gpt:latest-dev

RUN wget https://huggingface.co/jartine/Mistral-7B-Instruct-v0.2-llamafile/resolve/main/mistral-7b-instruct-v0.2.Q5_K_M.llamafile && \
    chmod +x mistral-7b-instruct-v0.2.Q5_K_M.llamafile && \
    bash ./mistral-7b-instruct-v0.2.Q5_K_M.llamafile --version
