FROM 	alpine:3.9.5
RUN 	set -exu ; \
	apk update ; \
	apk add apache2 ; \
	apk add php ; \
	apk add php-apache2 ; \
	apk add php7-redis ; \
	apk add php-mysqli ; \
	sed -i 's/^session.save_handler = files$/session.save_handler = redis/' /etc/php7/php.ini ; \
	sed -i '/session.save_handler/a session.save_path = "tcp://${redis_servicename}"' /etc/php7/php.ini ;\
	ln -sf /dev/stdout /var/log/apache2/access.log ; \
	ln -sf /dev/stderr /var/log/apache2/error.log ; \
        rm -f /var/cache/apk/* ; \
	rm -f /var/www/localhost/htdocs/* ; 

COPY    index.php /var/www/localhost/htdocs

ENTRYPOINT [ "/usr/sbin/httpd","-D","FOREGROUND" ]
EXPOSE 	80
