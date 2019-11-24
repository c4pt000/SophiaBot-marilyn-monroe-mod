FROM c4pt/marilyn-current-sophiabot:mod


RUN apt-get update && apt-get install pulseaudio-utils procps pulseaudio sudo x11-xserver-utils -y && DEBIAN_FRONTEND=noninteractive

# Replace 1000 with your user / group id

RUN export uid=0 gid=0 && \
    mkdir -p /home/developer && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    touch /etc/sudoers.d/developer && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown ${uid}:${gid} -R /home/developer && \
    gpasswd -a ${UNAME} audio   

COPY pulse-client.conf /etc/pulse/client.conf


USER developer
ENV HOME /home/developer
CMD /usr/bin/bash
