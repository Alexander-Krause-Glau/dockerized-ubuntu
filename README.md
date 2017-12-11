# dockerized-ubuntu
Comprehensive and dockerized development VM based on Ubuntu. Be careful, this image is huge (up to 10 GB). Data is not saved in external volumes.

## Includes tools
- Git
- Texlive2017
- Texstudio
- Java 8 JDK
- Eclipse Oxygen IDE for Java and DSL Developers
- Inkscape
- Gimp

## How to use
1. Run `docker run -id -p 56:22 -p 8080-8085:8080-8085 --name ubuntu -e "user=dummy" -e "pw=dummyPW" alexanderkrause/ubuntu`
2. Download X2Go Client for your OS: https://wiki.x2go.org/doku.php/download:start
3. Start X2Go Client. Use `localhost` as host, `56` as SSH port and `LXDE` as session type. Insert your self-chosen credentials as well.
