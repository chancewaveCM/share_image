FROM python:3.8.16

RUN apt-get update && apt-get install -y locales
RUN locale-gen ko_KR.UTF-8
ENV LC_ALL ko_KR.UTF-8

WORKDIR /news_collector

COPY dockerfile ./
RUN pip install fastapi

COPY ./ ./

EXPOSE 3000

ARG DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1

RUN sed -i '/CipherString = DEFAULT/s/^#\?/#/' /etc/ssl/openssl.cnf

CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "3000"]