![dockerhub](https://img.shields.io/docker/pulls/alexanderkrause/dockerized-ubuntu.svg)

# dockerized-ubuntu
Comprehensive and dockerized development image based on Ubuntu. Be careful, this image is huge (up to 10 GB). Data is not saved in external volumes.

This image is supposed to be used with a [X2Go Client](https://wiki.x2go.org/doku.php/download:start).

## Includes tools
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

## How to use
1. Pull the base image first `docker pull alexanderkrause/dockerized-ubuntu`

2. Create your custom Dockerfile based on [this example](https://github.com/Alexander-Krause/dockerized-ubuntu/blob/master/Dockerfile)

3. Build your custom image `docker build --build-arg user=dummy --build-arg pw=mypassword -t dockerized-ubuntu PATH/TO/DOCKERFILE/FOLDER`, e.g., `docker build --build-arg user=dummy --build-arg pw=mypassword -t dockerized-ubuntu .`

4. Create and run your container (you can additionally map a port range, e.g., `-p 8080-8085:8080-8085`): `docker run -id -p 56:22 dockerized-ubuntu`

5. Download X2Go Client for your OS: https://wiki.x2go.org/doku.php/download:start

6. Start X2Go Client. Use `localhost` as host, `56` as SSH port and `LXDE` as session type. Insert your self-chosen credentials as well and connect.

## Regarding SSH Security
At the moment, I am looking for the best way to use private keys in docker containers. Ultimately, I want to use a SSH agent forwarding. This does already work with the "-A" flag, e.g., `ssh -A dummy@localhost`, but X2Go (with the respective [workaround](https://wiki.x2go.org/doku.php/doc:howto:ssh-agent-workaround)) won't notice open SSH connections. Additionally, there is no valid and multi-OS-enabled way to inject a SSH agent into a docker container.