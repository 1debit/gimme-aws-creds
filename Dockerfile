#FROM python:3.7-alpine
FROM 676895163693.dkr.ecr.us-east-1.amazonaws.com/base-ubuntu:master-18.04

# ensure local python is preferred over distribution python
ENV PATH /usr/local/bin:$PATH

# http://bugs.python.org/issue19846
# > At the moment, setting "LANG=C" on a Linux system *fundamentally breaks Python 3*, and that's not OK.
ENV LANG C.UTF-8

ENV PYTHON_VERSION 3.7.7
# extra dependencies (over what buildpack-deps already includes)
RUN apt-get update && apt-get install -y --no-install-recommends \
		libbluetooth-dev \
    wget \
    build-essential \
    python3.7 \
    python3-pip \
    python3-venv \
    python3-setuptools \
		tk-dev \
		uuid-dev \
	&& rm -rf /var/lib/apt/lists/* 
  #&& cd /usr/local/bin \
	#&& ln -s idle3 idle \
	#&& ln -s pydoc3 pydoc \
	#&& ln -s python3 python \
	#&& ln -s python3-config python-config

WORKDIR /opt/gimme-aws-creds

COPY . .

RUN /usr/bin/python3.7 setup.py install

ENTRYPOINT ["/usr/local/bin/gimme-aws-creds"]
