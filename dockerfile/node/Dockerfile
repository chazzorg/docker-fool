ARG NODE_VERSION
FROM node:${NODE_VERSION}

LABEL maintainer="chazz"

#####################################
# Set Timezone
#####################################

ARG TZ=UTC
ENV TZ ${TZ}
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN mkdir -p /var/app

WORKDIR /var/app

ADD ./startup.sh /opt/startup.sh

CMD ["/bin/bash", "/opt/startup.sh"]