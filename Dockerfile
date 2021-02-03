FROM ubuntu:16.04

RUN sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list && apt update && apt-get install -y lib32z1 xinetd && rm -rf /var/lib/apt/lists/ && rm -rf /root/.cache && apt-get autoclean && rm -rf /tmp/* /var/lib/apt/* /var/cache/* /var/log/*
#apt update && apt-get install -y lib32z1 xinetd && rm -rf /var/lib/apt/lists/ && rm -rf /root/.cache && apt-get autoclean && rm -rf /tmp/* /var/lib/apt/* /var/cache/* /var/log/*

COPY ./pwn.xinetd /etc/xinetd.d/pwn

COPY ./service.sh /service.sh

RUN chmod +x /service.sh

# useradd and put flag
RUN useradd -m pwn1 && useradd -m pwn1_copy1 && useradd -m pwn1_copy2 && echo 'flag{f1023617-9772-4b4a-8637-ae911afac69c}' > /home/pwn1/flag.txt && echo 'flag{081f1411-fcab-4d1d-b016-ebc6e2be06b3}' > /home/pwn1_copy1/flag.txt && echo 'flag{e66a05d2-a98e-4326-a1b4-a4052a49549d}' > /home/pwn1_copy2/flag.txt

# copy bin
COPY ./bin/pwn1 /home/pwn1/pwn1
COPY ./catflag /home/pwn1/bin/sh
COPY ./bin/pwn1_copy1 /home/pwn1_copy1/pwn1_copy1
COPY ./catflag /home/pwn1_copy1/bin/sh
COPY ./bin/pwn1_copy2 /home/pwn1_copy2/pwn1_copy2
COPY ./catflag /home/pwn1_copy2/bin/sh


# chown & chmod
RUN chown -R root:pwn1 /home/pwn1 && chmod -R 750 /home/pwn1 && chmod 740 /home/pwn1/flag.txt && chown -R root:pwn1_copy1 /home/pwn1_copy1 && chmod -R 750 /home/pwn1_copy1 && chmod 740 /home/pwn1_copy1/flag.txt && chown -R root:pwn1_copy2 /home/pwn1_copy2 && chmod -R 750 /home/pwn1_copy2 && chmod 740 /home/pwn1_copy2/flag.txt

# copy lib,/bin 
RUN cp -R /lib* /home/pwn1 && cp -R /usr/lib* /home/pwn1 && mkdir /home/pwn1/dev && mknod /home/pwn1/dev/null c 1 3 && mknod /home/pwn1/dev/zero c 1 5 && mknod /home/pwn1/dev/random c 1 8 && mknod /home/pwn1/dev/urandom c 1 9 && chmod 666 /home/pwn1/dev/* && cp /bin/sh /home/pwn1/bin && cp /bin/ls /home/pwn1/bin && cp /bin/cat /home/pwn1/bin && cp -R /lib* /home/pwn1_copy1 && cp -R /usr/lib* /home/pwn1_copy1 && mkdir /home/pwn1_copy1/dev && mknod /home/pwn1_copy1/dev/null c 1 3 && mknod /home/pwn1_copy1/dev/zero c 1 5 && mknod /home/pwn1_copy1/dev/random c 1 8 && mknod /home/pwn1_copy1/dev/urandom c 1 9 && chmod 666 /home/pwn1_copy1/dev/* && cp /bin/sh /home/pwn1_copy1/bin && cp /bin/ls /home/pwn1_copy1/bin && cp /bin/cat /home/pwn1_copy1/bin && cp -R /lib* /home/pwn1_copy2 && cp -R /usr/lib* /home/pwn1_copy2 && mkdir /home/pwn1_copy2/dev && mknod /home/pwn1_copy2/dev/null c 1 3 && mknod /home/pwn1_copy2/dev/zero c 1 5 && mknod /home/pwn1_copy2/dev/random c 1 8 && mknod /home/pwn1_copy2/dev/urandom c 1 9 && chmod 666 /home/pwn1_copy2/dev/* && cp /bin/sh /home/pwn1_copy2/bin && cp /bin/ls /home/pwn1_copy2/bin && cp /bin/cat /home/pwn1_copy2/bin

CMD ["/service.sh"]
