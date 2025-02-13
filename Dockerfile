# Tested over Ubuntu 24.04
FROM ubuntu:latest

ARG DEPS_PKG="npm curl python3-distlib python3-distutils-extra"

RUN DEBIAN_FRONTEND=noninteractive apt update && apt install -y apt-utils \
                    && apt install -y ${DEPS_PKG} \
                    && apt clean -y && rm -rf /var/lib/apt/lists/*

# Add 'docker' user
ARG USER=docker
ARG UID=1000
ARG GID=1000
RUN groupadd -f -g ${GID} docker && ( getent passwd ${UID} || useradd -ms /bin/bash ${USER} -u ${UID} -g ${GID} )


SHELL ["/bin/bash", "-c"]
RUN npm i npm-run-all -g
RUN curl -qL https://www.npmjs.com/install.sh | sh

RUN mkdir -p /opt/bootstrap && chown ${UID}:${GID} /opt/bootstrap

USER ${UID}:${GID}
WORKDIR /opt/bootstrap

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
RUN source ~/.nvm/nvm.sh && nvm install 22

CMD [ "bash", "build.sh"]

