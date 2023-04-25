FROM quay.io/toolbx-images/alpine-toolbox:edge

LABEL com.github.containers.toolbox="true" \
      usage="This image is meant to be used with the toolbox or distrobox command" \
      summary="A cloud-native terminal experience" \
      maintainer="jorge.castro@gmail.com>"

COPY extra-packages /
RUN apk update && \
    apk upgrade && \
    grep -v '^#' /extra-packages | xargs apk add
RUN rm /extra-packages
ENV duf_version="0.8.1"
RUN curl -fsL "https://github.com/muesli/duf/releases/download/v${duf_version}/duf_${duf_version}_linux_amd64.apk" -o /duf.apk && \
      apk add --allow-untrusted /duf.apk && \
      rm -f /duf.apk
ENV host_spawn_version="1.2.1"
RUN curl -fsL "https://github.com/1player/host-spawn/releases/download/${host_spawn_version}/host-spawn-$(uname -m)" -o /usr/bin/host-spawn && \
      chmod +x /usr/bin/host-spawn
# ENV fastfetch_version="1.11.0"
# RUN curl -fsL "https://github.com/LinusDierheimer/fastfetch/releases/download/${fastfetch_version}/fastfetch-${fastfetch_version}-Linux.tar.gz" | tar -xzC / --strip-components=1

RUN   apk update && \
      apk upgrade && \
      ln -fs /bin/sh /usr/bin/sh && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/distrobox && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/docker && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/flatpak && \ 
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/podman && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/rpm-ostree && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/transactional-update
     
