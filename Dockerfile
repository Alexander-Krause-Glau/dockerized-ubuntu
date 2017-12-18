FROM alexanderkrause/dockerized-ubuntu:latest

# pass these variables, e.g., '--build-arg <varname>=<value> flag
ARG user=default
ARG pw=password

# add user
RUN \
useradd -ms /bin/bash ${user} && \
echo ${user}:${pw} | chpasswd && \
usermod -aG sudo ${user}

# workaround for SSH agent forwarding in X2Go
ADD x2go/workaround.bash.bashrc /tmp/workaround.bash.bashrc
RUN cat /tmp/workaround.bash.bashrc >> /etc/bash.bashrc

# copy public SSH key
COPY ssh/* /home/${user}/.ssh/

# set correct ssh permission
RUN chown -R ${user} /home/${user}/.ssh/ && chmod 600 /home/${user}/.ssh/*

# Only SSH for login
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config

# eclipse permission
RUN chown -R ${user} /opt/eclipse