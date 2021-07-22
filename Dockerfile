FROM golang:1.16

ENV GO111MODULE=on

RUN apt-get update \
    && apt-get install apt-transport-https software-properties-common -y \
        autoconf \
        autoconf-archive \
        automake \
        build-essential \
        cmake \
        g++ \
        git \
        libcairo2-dev \
        libicu-dev \
        libjpeg-dev \
        libpango1.0-dev \
        libgif-dev \
        libwebp-dev \
        libopenjp2-7-dev \
        libpng-dev \
        libtiff-dev \
        libtool \
        libarchive-dev \
        pkg-config \
        wget \
        xzgv \
        zlib1g-dev \
    && rm -rf /etc/apt/sources.list  \
    && echo "deb https://notesalexp.org/tesseract-ocr-dev/buster/ buster main" >> /etc/apt/sources.list \
    && wget -O - https://notesalexp.org/debian/alexp_key.asc | apt-key add - \
    && apt-get update -qq

ENV TESSDATA_PREFIX=/usr/share/tesseract-ocr/5/tessdata/

RUN apt-get install -y \
    libleptonica-dev \
    libtesseract-dev \
    tesseract-ocr \
    tesseract-ocr-fra

WORKDIR /app

COPY go.mod .
COPY go.sum .

RUN go mod download

COPY . .
