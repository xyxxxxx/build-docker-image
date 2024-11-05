FROM t9kpublic/auto-gpt:v0.5.1-1

RUN chmod +x mistral-7b-instruct-v0.2.Q5_K_M.llamafile && \
    ./mistral-7b-instruct-v0.2.Q5_K_M.llamafile --version
