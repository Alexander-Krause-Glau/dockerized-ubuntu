FROM ubuntu:latest
ARG DEBIAN_FRONTEND=noninteractive

ENV user user
ENV pw password

EXPOSE 22
EXPOSE 8080-8085

# update and enable package cache (necessary for package installations)
RUN apt-get update -qq -y

# install ssh for x2go
RUN apt-get install ssh -qq -y

# remove unity since it doesn't work with x2go
RUN \
apt-get remove unity -qq -y && \
apt-get dist-upgrade -qq -y

# install lubuntu
RUN \
apt-get install lubuntu-desktop -qq -y && \
# apt-get dist-upgrade -qq -y && \
apt-get autoclean -qq -y && \
apt-get autoremove -qq -y

# add user
#RUN \
#useradd -ms /bin/bash ${user} && \
#echo ${user}:${pw} | chpasswd && \
#usermod -aG sudo ${user}

# update apt source list
RUN \
echo "deb http://ppa.launchpad.net/x2go/stable/ubuntu xenial main" >> /etc/apt/sources.list && \
echo "deb-src http://ppa.launchpad.net/x2go/stable/ubuntu xenial main" >> /etc/apt/sources.list

# Update package list
RUN \
add-apt-repository ppa:x2go/stable && \
apt-get update -qq -y


# install x2go server
RUN \
apt-get install software-properties-common -qq -y && \
apt-get install x2goserver x2goserver-xsession x2golxdebindings x2godesktopsharing -qq -y

# install common tools
RUN apt-get -qq -y install git wget

# install java jdk 8
RUN \
mkdir -p /tmp/java && \
wget -P /tmp/java/ -q --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u151-b12/e758a0de34e24606bca991d704f6dcbf/jdk-8u151-linux-x64.tar.gz && \
mkdir -p /usr/lib/jvm/ && tar -xzf /tmp/java/jdk-8u151-linux-x64.tar.gz -C /usr/lib/jvm/ && \
update-alternatives --install "/usr/bin/java" "java" "/usr/lib/jvm/jdk1.8.0_151/bin/java" 1 && \
update-alternatives --install "/usr/bin/javac" "javac" "/usr/lib/jvm/jdk1.8.0_151/bin/javac" 1 && \
update-alternatives --install "/usr/bin/javaws" "javaws" "/usr/lib/jvm/jdk1.8.0_151/bin/javaws" 1

# install eclipse IDE
RUN \
mkdir /opt/eclipse && cd opt/eclipse && \
wget -O eclipse.tar.gz -q http://www.mirrorservice.org/sites/download.eclipse.org/eclipseMirror/technology/epp/downloads/release/oxygen/1a/eclipse-dsl-oxygen-1a-linux-gtk-x86_64.tar.gz && \
tar -xzf eclipse.tar.gz --strip 1 && \
ln -s /opt/eclipse/eclipse /usr/local/bin

# install texlive2017 and texstudio
RUN \
add-apt-repository ppa:jonathonf/texlive-2017 && \
apt-get update -qq -y && \
apt-get -qq -y install texlive-full && \
apt-get -qq -y install texstudio && \
apt-get -qq -y install xzdec

# install graphic processing tools
RUN \ 
apt-get -qq -y install inkscape && \
apt-get -qq -y install gimp

# install Sublime texteditor
RUN \
add-apt-repository ppa:webupd8team/sublime-text-3 && \
apt-get update -qq -y && \
apt-get -qq -y install sublime-text-installer

CMD ["sh", "-c", "service ssh start; useradd -ms /bin/bash ${user}; echo ${user}:${pw} | chpasswd; usermod -aG sudo ${user}; chown -R ${user} /opt/eclipse; bash"]
