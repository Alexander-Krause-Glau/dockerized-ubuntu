FROM alexanderkrause/dockerized-ubuntu:latest

# pass these variables, e.g., '--build-arg <varname>=<value> flag
ARG user=default
ARG pw=password

# add user
RUN \
  useradd -ms /bin/bash ${user} && \
  echo ${user}:${pw} | chpasswd && \
  usermod -aG sudo ${user}

# workaround for SSH agent forwarding in X2Go 1
ADD \
  x2go/workaround.bash.bashrc /tmp/workaround.bash.bashrc

# File endings fix (Windows compatibility)
RUN \
  apt-get install -qq -y dos2unix && \
  dos2unix /tmp/workaround.bash.bashrc && \
  apt-get --purge remove -y dos2unix

# workaround for SSH agent forwarding in X2Go 2
RUN \
  cat /tmp/workaround.bash.bashrc >> /etc/bash.bashrc

# copy public SSH key
COPY \
  ssh/* /home/${user}/.ssh/

# Only SSH for login and set correct permissions
RUN \
  sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config && \
  chown -R ${user} /home/${user}/.ssh/ && chmod 600 /home/${user}/.ssh/* && \
  chown -R ${user} /opt/eclipse

# install node.js and ember
RUN \
  apt-get -qq -y install curl && \
  curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash - && \
  apt-get install -qq -y nodejs && \
  apt-get install -qq -y build-essential && \
  npm install -g ember-cli@2.17
