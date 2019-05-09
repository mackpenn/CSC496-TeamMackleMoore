set -x
sudo apt-get update
sudo apt-get install -y build-essential libssl-dev uuid-dev libgpgme11-dev squashfs-tools wget git
export VERSION=1.11 OS=linux ARCH=amd64
cd /tmp
sudo wget https://dl.google.com/go/go$VERSION.$OS-$ARCH.tar.gz
sudo tar -C /usr/local -xzf go$VERSION.$OS-$ARCH.tar.gz
echo 'export GOPATH=${HOME}/go' >> ~/.bashrc
echo 'export PATH=/usr/local/go/bin:${PATH}:${GOPATH}/bin' >> ~/.bashrc
source ~/.bashrc
mkdir -p $GOPATH/src/github.com/sylabs
cd $GOPATH/src/github.com/sylabs
sudo git clone https://github.com/sylabs/singularity.git
cd singularity
go get -u -v github.com/golang/dep/cmd/dep
cd $GOPATH/src/github.com/sylabs/singularity
./mconfig
sudo make -C builddir
sudo make -C builddir install
sudo singularity build --sandbox ubuntu/ library://ubuntu
sudo singularity exec --writable ubuntu apt-get update
sudo singularity exec --writable ubuntu apt-get install -y fio


sudo mkdir streamDirectory
sudo cd streamDirectory
sudo wget https://www.cs.virginia.edu/stream/FTP/Code/stream.c
sudo apt-get update
sudo wget https://www.cs.virginia.edu/stream/FTP/Code/mysecond.c
sudo apt-get install -y gcc
sudo gcc -O stream.c -o stream
