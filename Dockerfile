FROM rust as builder
RUN apt update && apt install -y build-essential
# Install mdbook
RUN cargo install mdbook
RUN cargo install mdbook-pandoc
RUN cargo install mdbook-katex

FROM python as base
RUN apt update \
    && apt install -y pandoc texlive-full \
    && apt autoremove -y \
    && apt clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && rm -rf /root/.cache

COPY --from=builder /usr/local/cargo/bin/mdbook /usr/local/bin/mdbook
COPY --from=builder /usr/local/cargo/bin/mdbook-pandoc /usr/local/bin/mdbook-pandoc
COPY --from=builder /usr/local/cargo/bin/mdbook-katex /usr/local/bin/mdbook-katex
WORKDIR /book

# Add other mdbook backend at /mdbook dir
ENV PATH="$PATH:/mdbook"

ENTRYPOINT [ "mdbook", "build" ]
