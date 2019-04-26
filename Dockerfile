FROM ubuntu
RUN apt-get update
RUN apt-get install -y wget

RUN mkdir streamDirectory
RUN cd streamDirectory
RUN wget https://www.cs.virginia.edu/stream/FTP/Code/stream.c
RUN apt-get update
RUN wget https://www.cs.virginia.edu/stream/FTP/Code/mysecond.c
RUN apt-get install -y gcc
RUN gcc -O stream.c -o stream
CMD ["/bin/bash"]
