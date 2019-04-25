Simple test to see if we can grab and compile Stream through a Dockerfile

RUN mkdir streamDirectory
    cd streamDirectory
    sudo wget https://www.cs.virginia.edu/stream/FTP/Code/stream.c
    sudo wget https://www.cs.virginia.edu/stream/FTP/Code/mysecond.c
    sudo gcc -O stream.c -o stream
    sudo touch StreamOutput.txt
    ./stream > StreamOutput.txt\
    
CMD ["/bin/bash"]
