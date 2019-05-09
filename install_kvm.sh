set -x
sudo apt-get update
sudo apt-get install -qqy qemu-kvm libvirt-bin ubuntu-vm-builder bridge-utils virt-manager libosinfo-bin libguestfs-tools virt-top
sudo adduser `id -un` libvirt
wget http://releases.ubuntu.com/14.04/ubuntu-14.04.6-server-amd64.iso
qemu-img create -f qcow2 ubuntu.qcow2 20G
sudo virt-install --name test --connect qemu:///system --ram 64000 --disk path=ubuntu.qcow2,format=qcow2,bus=virtio,size=8 --vcpus 32 --os-type linux --network network=default --graphics none --console pty,target_type=serial --location=ubuntu-14.04.6-server-amd64.iso --extra-args 'console=ttyS0'
sudo apt-get update
sudo apt-get install -qqy fio
## sudo fio --name=randwrite --ioengine=libaio --iodepth=1 --rw=randwrite --bs=4k --direct=0 --size=512M --numjobs=2 --runtime=240 --group_reporting > RandomWrite.txt
## sudo fio --name=randread --ioengine=libaio --iodepth=16 --rw=randread --bs=4k --direct=0 --size=256M --numjobs=2 --runtime=240 --group_reporting
## sudo fio --randrepeat=1 --ioengine=libaio --direct=1 --gtod_reduce=1 --name=test --filename=random_read_write.fio --bs=4k --iodepth=64 --size=256M --readwrite=randrw --rwmixread=75 > ReadWritePerformance.txt

sudo apt-get update
##touch Dockerfile.txt
##echo -e 'RUN mkdir streamDirectory \ncd streamDirectory \nsudo wget https://www.cs.virginia.edu/stream/FTP/Code/stream.c \nsudo wget https://www.cs.virginia.edu/stream/FTP/Code/mysecond.c \nsudo gcc -O stream.c -o stream \nsudo touch StreamOutput.txt \n./stream > StreamOutput.txt\ \nCMD ["/bin/bash"]' > Dockerfile.txt

mkdir streamDirectory
cd streamDirectory
sudo wget https://www.cs.virginia.edu/stream/FTP/Code/stream.c
sudo wget https://www.cs.virginia.edu/stream/FTP/Code/mysecond.c
sudo gcc -O stream.c -o stream
sudo touch StreamOutput.txt
./stream > StreamOutput.txt
