FROM ubuntu
USER root

RUN apt -y update
RUN apt -y install python3 python3-pip git vim

WORKDIR /workspace

RUN git clone https://github.com/tgalal/yowsup.git ./yowsup

RUN pip install pyaxmlparser
COPY ./scripts ./scripts
COPY ./resources ./resources
RUN bash ./scripts/init.bash
RUN ln -s /usr/local/bin/yowsup-cli /usr/local/bin/yowsup