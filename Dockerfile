FROM python:3.11-slim-bullseye

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    bash \
    curl \
    git \
    neofetch \
    ffmpeg \
    tesseract-ocr \
    libsqlite3-dev \
    libzbar0 \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /root/LaylaRobot/

COPY requirements.txt .
RUN pip3 install --no-cache-dir -U pip && \
    pip3 install --no-cache-dir -U -r requirements.txt

COPY . .

RUN mkdir -p /root/LaylaRobot/LaylaRobot/ && \
    (cp ./LaylaRobot/sample_config.py /root/LaylaRobot/LaylaRobot/sample_config.py 2>/dev/null || echo "File not found") && \
    (cp ./LaylaRobot/config.py* /root/LaylaRobot/LaylaRobot/ 2>/dev/null || echo "File not found")

CMD ["python3", "-m", "LaylaRobot"]
