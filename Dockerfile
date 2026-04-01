FROM python:3.11-slim

ENV PYTHONUNBUFFERED 1
ENV PIP_NO_CACHE_DIR 1

# Fix Debian repositories for better package availability
RUN echo "deb http://deb.debian.org/debian bookworm main contrib non-free" > /etc/apt/sources.list && \
    echo "deb http://deb.debian.org/debian bookworm-updates main contrib non-free" >> /etc/apt/sources.list && \
    echo "deb http://security.debian.org/debian-security bookworm-security main contrib non-free" >> /etc/apt/sources.list

# Update and install required packages
RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    bash \
    bzip2 \
    curl \
    figlet \
    git \
    util-linux \
    libffi-dev \
    libjpeg-dev \
    python3-lxml \
    libpq-dev \
    libcurl4-openssl-dev \
    libxml2-dev \
    libxslt1-dev \
    python3-pip \
    python3-requests \
    python3-sqlalchemy \
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
    unzip \
    libopus0 \
    libopus-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists /var/cache/apt/archives /tmp

# Upgrade pip
RUN pip install --upgrade pip setuptools

# Clone repository
RUN git clone -b shiken https://github.com/QueenArzoo/LaylaRobot /root/LaylaRobot
WORKDIR /root/LaylaRobot

# Create directory and copy config files properly
RUN mkdir -p /root/LaylaRobot/LaylaRobot/

COPY ./LaylaRobot/sample_config.py /root/LaylaRobot/LaylaRobot/sample_config.py 2>/dev/null || echo "sample_config.py not found"

COPY ./LaylaRobot/config.py* /root/LaylaRobot/LaylaRobot/ 2>/dev/null || echo "config.py not found"

ENV PATH="/home/bot/bin:$PATH"

# Install requirements
RUN pip install -U -r requirements.txt

# Start bot
CMD ["python3","-m","LaylaRobot"]