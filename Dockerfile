ARG BUILD_FROM
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# WORKDIR /

RUN \
    apk add --no-cache \
    \
    ffmpeg

    
ARG PYTHON_VERSION="v3.12.5"
ARG PYTHON_PIP_VERSION="24.2"
ARG PYTHON_SETUPTOOLS_VERSION="72.1.0"

ARG YTDLP2STRM_COMMIT="3412e7a"

RUN \
    curl -L -o /tmp/ytdlp2STRM-${YTDLP2STRM_COMMIT}.tar.gz "https://github.com/fe80Grau/ytdlp2STRM/archive/${YTDLP2STRM_COMMIT}.tar.gz" \
    \
    && mkdir -p /opt/ytdlp2STRM \
    \
    && tar -zxvf /tmp/ytdlp2STRM-${YTDLP2STRM_COMMIT}.tar.gz --strip 1 -C /opt/ytdlp2STRM \
    \
    && cd /opt/ytdlp2STRM \
    \
    && python3 -m pip install --no-cache-dir --upgrade -r requierments.txt

# RUN \
#     apk del --no-cache --purge .build-dependencies
#     \
# RUN find /usr \
#         \( -type d -a -name test -o -name tests -o -name '__pycache__' \) \
#         -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
#         -exec rm -rf '{}' + \
#     \
RUN rm -f -r \
        /root/.cache \
        /root/.cmake \
        /tmp/*


# # Create the user and group ytdlp2strm
RUN addgroup -S ytdlp2strm && adduser -S -G ytdlp2strm ytdlp2strm

# Change ownership of /opt/ytdlp2STRM to ytdlp2strm:ytdlp2strm
RUN \
    chown -R ytdlp2strm:ytdlp2strm /opt/ytdlp2STRM \
    \
    && chmod -R 750 /opt/ytdlp2STRM

# Copy root filesystem for s6-overlay
COPY rootfs /

# No init
# COPY run.sh /
# RUN chmod a+x /run.sh
# CMD ["/run.sh"]
# EXPOSE 5000    

# Build arugments
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION
ARG BUILD_REPOSITORY

# Labels
LABEL \
    io.hass.name="ytdlp2STRM for ${BUILD_ARCH}" \
    io.hass.description="Home Assistant Community Add-on: ${BUILD_ARCH} ytdlp2STRM" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="github.com/saya6k" \
    org.opencontainers.image.title="ytdlp2STRM for ${BUILD_ARCH}" \
    org.opencontainers.image.description="Home Assistant Add-on: ${BUILD_ARCH} ytdlp2STRM" \
    org.opencontainers.image.vendor="Home Assistant Add-ons" \
    org.opencontainers.image.authors="github.com/saya6k" \
    org.opencontainers.image.licenses="GPLv3" \
    org.opencontainers.image.url="https://addons.community" \
    org.opencontainers.image.source="https://github.com/${BUILD_REPOSITORY}" \
    org.opencontainers.image.documentation="https://github.com/${BUILD_REPOSITORY}/blob/master/README.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}