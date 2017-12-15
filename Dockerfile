FROM alexanderkrause/dockerized-ubuntu:latest

# pass these variables, e.g., '--build-arg <varname>=<value> "USER:alex" flag
ARG user=default
ARG pw=password

# copy SSH key
COPY PATH/TO/PRIVATE/KEY ${user}/.ssh/
COPY PATH/TO/PUBLIC/KEY ${user}/.ssh/

# copy GPG key
COPY PATH/TO/GNUPG/KEY ${user}/.gnupg/

# add user
RUN \
useradd -ms /bin/bash ${user} && \
echo ${user}:${pw} | chpasswd && \
usermod -aG sudo ${user}

# eclipse permission
RUN chown -R ${user} /opt/eclipse