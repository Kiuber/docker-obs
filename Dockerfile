FROM kiuber/gui-docker:latest

USER root

RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update -y \
    && apt-get install -y software-properties-common \
    && add-apt-repository ppa:obsproject/obs-studio \
    && apt-get update -y \
    && apt-get install -y ffmpeg obs-studio \
    && apt-get install -y binutils \
    && apt-get clean -y

# https://obsproject.com/forum/threads/obs-studio-libqt5core-so-5-not-found.133685/post-491308
RUN strip --remove-section=.note.ABI-tag /usr/lib/x86_64-linux-gnu/libQt5Core.so.5

RUN echo "?package(bash):needs=\"X11\" section=\"DockerCustom\" title=\"OBS Screencast\" command=\"obs\"" >> /usr/share/menu/custom-docker && update-menus

USER dockerUser
