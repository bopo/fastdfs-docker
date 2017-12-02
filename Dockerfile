FROM alpine:3.6
ENV PYTHONUNBUFFERED 1

ADD entrypoint.sh /entrypoint.sh
RUN echo 'http://mirrors.aliyun.com/alpine/v3.6/main/' > /etc/apk/repositories
RUN echo 'http://mirrors.aliyun.com/alpine/v3.6/community/' >> /etc/apk/repositories

RUN apk add --no-cache --virtual .build-deps automake autoconf libevent make git libc-dev gcc

RUN git clone --recursive https://github.com/happyfish100/libfastcommon.git ~/libfastcommon
RUN git clone --recursive https://github.com/happyfish100/fastdfs.git ~/fastdfs

RUN cd ~/libfastcommon; ./make.sh; ./make.sh install
RUN cd ~/fastdfs; ./make.sh; ./make.sh install
RUN rm -rf ~/fastdfs ~/libfastcommon
RUN apk del .build-deps

ENTRYPOINT ["/entrypoint.sh"]