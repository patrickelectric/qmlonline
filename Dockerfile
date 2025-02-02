FROM ubuntu:24.04

RUN apt-get -y update && DEBIAN_FRONTEND=noninteractive apt-get -y install \
    git \
    cmake \
    python3 \
    python3-pip \
    build-essential \
    libdbus-1-3 \
    libpulse-mainloop-glib0

RUN pip3 install aqtinstall --break-system-packages

ARG QT=6.8.1
RUN aqt install-qt all_os wasm ${QT} wasm_singlethread --autodesktop --modules all
ENV PATH /${QT}/wasm_singlethread/bin:$PATH
ENV QT_PLUGIN_PATH /${QT}/wasm_singlethread/plugins/
ENV QML_IMPORT_PATH /${QT}/wasm_singlethread/qml/
ENV QML2_IMPORT_PATH /${QT}/wasm_singlethread/qml/

RUN apt install -y emscripten

# Set default working directory
WORKDIR /home/user

# set entrypoint
ENTRYPOINT ["/usr/bin/bash"]