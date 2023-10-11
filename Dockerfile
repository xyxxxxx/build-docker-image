FROM opendilab/ding:nightly

RUN conda install -y x264=='1!152.20180717' ffmpeg=4.0.2 -c conda-forge && \
    conda clean -ya
