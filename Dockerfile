FROM python:3.11-slim-buster

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    debian-keyring \
    debian-archive-keyring \
    bash \
    curl \
    git \
    neofetch \
    ffmpeg \
    libsqlite3-dev \
    libzbar0 \
    python3-pip \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /root/LaylaRobot/

COPY requirements.txt .
RUN pip3 install --no-cache-dir -U -r requirements.txt

COPY . .

# Corrected the syntax error for 2026 deployment
RUN mkdir -p /root/LaylaRobot/LaylaRobot/ && \
    cp ./LaylaRobot/sample_config.py /root/LaylaRobot/LaylaRobot/sample_config.py 2>/dev/null || echo "sample_config.py not found" && \
    cp ./LaylaRobot/config.py* /root/LaylaRobot/LaylaRobot/ 2>/dev/null || echo "config.py not found"

CMD ["python3", "-m", "LaylaRobot"]
