FROM openjdk:8 
WORKDIR /app
ADD init.sh ./
#ADD artifact/* ./
COPY hello.jar /app
RUN chmod +x init.sh
# ssh
ENV SSH_PASSWD "root:Docker!"
RUN apt-get update \
        && apt-get install -y --no-install-recommends dialog \
        && apt-get update \
    && apt-get install -y --no-install-recommends openssh-server \
    && echo "$SSH_PASSWD" | chpasswd 

COPY sshd_config /etc/ssh/
ENTRYPOINT ["/app/init.sh"]
EXPOSE 2222 8080 8280 80