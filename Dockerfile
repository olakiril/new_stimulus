FROM ninai/pipeline:base

LABEL maintainer="Jiakun Fu <jiakun.fu.bcm@gmail.com>"

WORKDIR /data


# --- install scanreader
RUN \
  git clone https://github.com/atlab/scanreader.git && \
  pip3 install -e scanreader

# --- install pipeline
RUN git clone https://github.com/cajal/pipeline.git && \
    pip3 install -e pipeline/python/
    
# --- install stimuli
ADD . /data/stimuli
RUN pip3 install -e stimuli/python/

RUN git clone https://github.com/atlab/commons.git && \
    pip3 install -e commons/python

ENTRYPOINT ["worker"]
