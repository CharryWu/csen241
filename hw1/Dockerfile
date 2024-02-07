FROM ubuntu:20.04

RUN apt update
RUN apt install sysbench -y
COPY run_testcase.sh /
ENTRYPOINT ["/run_testcase.sh"]
