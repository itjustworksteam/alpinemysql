FROM alpine:3.4
RUN apk update && apk upgrade && apk add --update mysql mysql-client && rm -f /var/cache/apk/*
WORKDIR /app
VOLUME /app
# /sql where you put all the .sql file to import
VOLUME /sql
COPY run.sh /run.sh
COPY my.cnf /etc/mysql/my.cnf
EXPOSE 3306
CMD ["/bin/sh", "/run.sh"]