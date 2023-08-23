FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    software-properties-common \
    nginx \
    composer \
    nano \
    curl  
RUN apt install -y php8.1-fpm php8.1-bcmath php8.1-cli php8.1-common php8.1-curl php8.1-dev php8.1-fpm php8.1-gd php8.1-imagick php8.1-mbstring php8.1-memcache php8.1-mongodb php8.1-mysql php8.1-redis
RUN apt install -y php8.1-opcache php8.1-pgsql php8.1-pspell php8.1-readline php8.1-snmp php8.1-sqlite3 php8.1-ssh2 php8.1-xml php8.1-xmlrpc php8.1-xsl php8.1-zip

RUN curl -sS https://getcomposer.org/installer | php 
RUN mv composer.phar /usr/local/bin/composer
RUN composer global require laravel/installer

RUN apt-get install -y nodejs npm
RUN apt install -y python3 pip

WORKDIR /app
RUN rm /etc/nginx/sites-enabled/default

COPY . .
RUN chmod 777 -R /app

COPY ./nginx/default /etc/nginx/sites-enabled/

WORKDIR /app/new-py

RUN pip3 install -r requirements.txt

WORKDIR /app/Laravel
RUN composer install

WORKDIR /app/vue
RUN npm install

WORKDIR /app/node
RUN npm install
EXPOSE 80

CMD ["sh", "-c", "service php8.1-fpm start & cd /app/new-py & python3 /app/new-py/app.py & cd /app/node & npm install & node /app/node/index.js & cd /app/vue & npm run serve & nginx -g 'daemon off;'"]
