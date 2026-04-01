# Use a newer Python version
FROM python:3.11-slim-bullseye

ENV PIP_NO_CACHE_DIR 1

# Fix apt sources
RUN sed -i 's|http://deb.debian.org|http://archive.debian.org|g' /etc/apt/sources.list && \
    sed -i 's|http://security.debian.org|http://archive.debian.org|g' /etc/apt/sources.list && \
    echo "deb http://archive.debian.org/debian bullseye main" > /etc/apt/sources.list.d/bullseye.sources.list

# Installing Required Packages
RUN apt-get update && apt-get upgrade -y && \
    apt-get install --no-install-recommends -y \
    bash \
    bzip2 \
    curl \
    figlet \
    git \
    util-linux \
    libffi-dev \
    libjpeg-dev \
    libjpeg62-turbo-dev \
    libwebp-dev \
    python3-lxml \
    postgresql-client \
    libpq-dev \
    libcurl4-openssl-dev \
    libxml2-dev \
    libxslt1-dev \
    python3-pip \
    python3-requests \
    python3-sqlalchemy \
    python3-tz \
    python3-aiohttp \
    openssl \
    pv \
    jq \
    wget \
    python3-dev \
    libreadline-dev \
    libyaml-dev \
    gcc \
    sqlite3 \
    libsqlite3-dev \
    sudo \
    zlib1g \
    ffmpeg \
    libssl-dev \
    libxi6 \
    unzip \
    libopus0 \
    libopus-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists /var/cache/apt/archives /tmp

# Pypi package Repo upgrade
RUN pip3 install --upgrade pip setuptools

# Copy Python Requirements to /root/LaylaRobot
RUN git clone -b shiken https://github.com/QueenArzoo/LaylaRobot /root/LaylaRobot
WORKDIR /root/LaylaRobot

# Copy config file to /root/LaylaRobot/LaylaRobot
COPY ./LaylaRobot/sample_config.py ./LaylaRobot/config.py* /root/LaylaRobot/LaylaRobot/

ENV PATH="/home/bot/bin:$PATH"

# Install requirements
RUN pip3 install -U -r requirements.txt

# Starting Worker
CMD ["python3","-m","LaylaRobot"]