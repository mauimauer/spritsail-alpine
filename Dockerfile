ARG ALPINE_TAG=edge

FROM alpine:$ALPINE_TAG

ARG ALPINE_TAG

LABEL maintainer="Spritsail <alpine@spritsail.io>" \
      org.label-schema.vendor="Spritsail" \
      org.label-schema.name="Alpine Linux" \
      org.label-schema.url="https://github.com/gliderlabs/docker-alpine" \
      org.label-schema.description="Alpine Linux base image" \
      org.label-schema.version=${ALPINE_TAG}

# Override shell for sh-y debugging goodness
SHELL ["/bin/sh", "-exc"]

COPY skel/ /
ADD https://alpine.spritsail.io/spritsail-alpine.rsa.pub /etc/apk/keys

ENV ENV="/etc/profile"
RUN sed -i '1ihttps://alpine.spritsail.io/spritsail' /etc/apk/repositories \
 && apk --no-cache add \
        su-exec \
        tini

ENTRYPOINT ["/sbin/tini" , "--"]
