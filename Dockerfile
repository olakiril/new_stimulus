FROM ninai/pipeline

LABEL maintainer="Jiakun Fu <jiakun.fu.bcm@gmail.com>"

WORKDIR /data

# --- install stimuli
ADD . /data/stimuli
RUN pip3 install -e stimuli/python/

ENTRYPOINT []
