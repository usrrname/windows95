# DESCRIPTION:	  Run Windows 95 in a container
# AUTHOR:		  Paul DeCarlo <toolboc@gmail.com>
#
#   Made possible through prior art by:
#   copy (v86 - x86 virtualization in JavaScript) 
#   felixrieseberg (Windows95 running in electron) 
#   Microsoft (Windows 95)
#
#   ***Docker Run Command***
#
#   docker run -it \
#    -v /tmp/.X11-unix:/tmp/.X11-unix \ # mount the X11 socket
#    -e DISPLAY=unix$DISPLAY \ # pass the display
#    --device /dev/snd \ # sound
#    --name windows95 \
#    toolboc/windows95
#
#   ***TroubleShooting***
#   If you receive Gtk-WARNING **: cannot open display: unix:0
#   Run:
#       xhost +
#

FROM node:16-bullseye

LABEL maintainer="usrrname"

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libgtk-3-0 \
    libcanberra-gtk3-module \
    libx11-xcb-dev \
    libgconf2-dev \
    libnss3 \
    libasound2 \
    libxtst-dev \
    libxss1 \
    git \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

# Create app directory and set permissions
WORKDIR /app
ENV NODE_ENV=development

# Copy package files first
COPY package*.json ./
COPY patches ./patches

# Install dependencies
RUN npm config set legacy-peer-deps true && \
    npm install -g @electron-forge/cli@6.0.5 patch-package && \
    npm install fs-extra@9.1.0 glob@7.2.3 rimraf@3.0.2 && \
    npm cache clean --force && \
    npm install --legacy-peer-deps --force --no-package-lock && \
    npm rebuild

# Copy the rest of the application
COPY . .

ENTRYPOINT [ "npm", "start"]
