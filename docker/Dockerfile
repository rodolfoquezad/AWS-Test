FROM ubuntu:22.04

#Instalacion de herramientas solicitadas

ENV DEBIAN_FRONTEND=noninteractive
RUN ln -fs /usr/share/zoneinfo/America/Mexico_City /etc/localtime

RUN apt-get update && apt-get install -y \
    maven \
    git \
    wget \
    curl \
    apache2 \
    openjdk-21-jdk \
    postgresql-client \
    dotnet-sdk-6.0 \
    libpq-dev \
    php \
    php-pgsql \         
    php-common \         
    && rm -rf /var/lib/apt/lists/*

#Instalacion de VS code server

RUN wget https://github.com/coder/code-server/releases/download/v4.101.2/code-server-4.101.2-linux-amd64.tar.gz \
    && tar -xzvf code-server-4.101.2-linux-amd64.tar.gz \
    && mv code-server-4.101.2-linux-amd64 /opt/code-server \
    && rm code-server-4.101.2-linux-amd64.tar.gz

#Configuracion de apache

COPY html/index.php /var/www/html
RUN chown -R www-data:www-data /var/www/html \
    && a2enmod rewrite \
    && service apache2 restart

# Variables de entorno
ENV PATH="/opt/code-server/bin:${PATH}"

# Puerto para VS Code Server y Apache
EXPOSE 8080 80

# Comando de inicio
CMD ["/bin/bash", "-c", "code-server --bind-addr 0.0.0.0:8080 & apache2ctl start && tail -f /var/log/apache2/access.log"]