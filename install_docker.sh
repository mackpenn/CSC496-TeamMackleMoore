#!/bin/bash
set -x
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common tmux
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose
sudo apt-get install -y httping
sudo apt-get install -y jq

# the username needs to be changed
sudo usermod -aG docker mp852958

sudo docker pull ubuntu:latest
sudo docker run -it container1 --rm ubuntu:latest
apt-get update
apt-get install -y fio
fio --name=randwrite --ioengine=libaio --iodepth=1 --rw=randwrite --bs=4k --direct=0 --size=512M --numjobs=2 --runtime=240 --group_reporting > RandomWrite.txt
fio --name=randread --ioengine=libaio --iodepth=16 --rw=randread --bs=4k --direct=0 --size=512M --numjobs=4 --runtime=240 --group_reporting > RandomRead.txt
fio --randrepeat=1 --ioengine=libaio --direct=1 --gtod_reduce=1 --name=test --filename=random_read_write.fio --bs=4k --iodepth=64 --size=4G --readwrite=randrw --rwmixread=75 > ReadWritePerformance.txt

## added by Cameron to test automatic docker stuff. Will rearrange and add FIO soon

sudo mkdir dockerDir
sudo curl -o Dockerfile https://raw.githubusercontent.com/mackpenn/CSC496-TeamMackleMoore/docker/Dockerfile
sudo mv Dockerfile dockerDir
sudo docker image ls
sudo docker build -t benchmarks ./dockerDir
##sudo docker build -t benchmarks /dockerDir
sudo touch streamOutput.txt
sudo docker run benchmarks ./stream > streamOutput.txt
