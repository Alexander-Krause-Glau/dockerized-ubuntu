![dockerhub](https://img.shields.io/docker/pulls/alexanderkrause/dockerized-ubuntu.svg)

# dockerized-ubuntu
Comprehensive and dockerized development image based on Ubuntu. Be careful, this image is huge (up to 10 GB). Data is not saved in external volumes.

This image is supposed to be used with a [X2Go Client](https://wiki.x2go.org/doku.php/download:start).

## Included tools and technologies
- Git
- Wget
- Vim
- Texlive2017
- Texstudio
- Java 8 JDK
- Eclipse Oxygen IDE for Java and DSL Developers
- Sublime
- Inkscape
- Gimp
- Node.js
- Ember.js

## How to use
1. Pull the base image first `docker pull alexanderkrause/dockerized-ubuntu`

2. Clone this repository

3. Create your custom Dockerfile based on [this example](https://github.com/Alexander-Krause/dockerized-ubuntu/blob/master/Dockerfile)
  * The exemplary Dockerfile results in a container allowing only SSH login. Therefore, put your public key renamed as *authorized_keys* in the ssh folder

4. Build your custom image `docker build --build-arg user=dummy --build-arg pw=mypassword -t dockerized-ubuntu PATH/TO/DOCKERFILE/FOLDER`, e.g., `docker build --build-arg user=dummy --build-arg pw=mypassword -t dockerized-ubuntu .`

5. Create and run your container (you can additionally map a port range, e.g., `-p 8080-8085:8080-8085`): `docker run -id -p 56:22 dockerized-ubuntu`

6. Connect to the container via SSH and agent forwarding, i.e., `ssh -A dummy@localhost`. Keep this connection open

6. Download [X2Go Client](https://wiki.x2go.org/doku.php/download:start) for your OS

7. Start X2Go Client. Use `localhost` as host, `56` as SSH port and `LXDE` as session type. Insert your self-chosen credentials as well and connect.

## Regarding SSH Security
I don't want to store my private keys in docker containers. Therefore, this image uses SSH agent forwarding instead of docker volume bindings or copying the file. Unfortunately, there is a bug in X2Go, thus a workaround is needed (contained in x2go folder and used by the exemplary [Dockerfile](https://github.com/Alexander-Krause/dockerized-ubuntu/blob/master/Dockerfile)). *Step 6* enables the workaround.
