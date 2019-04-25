RUN mkdir streamDirectory
    cd streamDirectory
    sudo wget https://www.cs.virginia.edu/stream/FTP/Code/stream.c
    sudo wget https://www.cs.virginia.edu/stream/FTP/Code/mysecond.c
    sudo gcc -O stream.c -o stream
    sudo touch StreamOutput.txt
    ./stream > StreamOutput.txt\
    
CMD ["/bin/bash"]
