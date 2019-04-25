set -x
sudo apt-get update
sudo apt-get install -qqy qemu-kvm libvirt-bin ubuntu-vm-builder bridge-utils virt-manager libosinfo-bin libguestfs-tools virt-top
sudo adduser `id -un` libvirt
wget http://releases.ubuntu.com/14.04/ubuntu-14.04.6-server-amd64.iso
qemu-img create -f qcow2 ubuntu.qcow2 20G
sudo virt-install --name test --connect qemu:///system --ram 10240 --disk path=ubuntu.qcow2,format=qcow2,bus=virtio,size=8 --vcpus 8 --os-type linux --network network=default --graphics none --console pty,target_type=serial --location=ubuntu-14.04.6-server-amd64.iso --extra-args 'console=ttyS0'
sudo apt-get update
sudo apt-get install -qqy fio
sudo fio --name=randwrite --ioengine=libaio --iodepth=1 --rw=randwrite --bs=4k --direct=0 --size=512M --numjobs=2 --runtime=240 --group_reporting > RandomWrite.txt
sudo fio --name=randread --ioengine=libaio --iodepth=16 --rw=randread --bs=4k --direct=0 --size=512M --numjobs=4 --runtime=240 --group_reporting > RandomRead.txt
sudo fio --randrepeat=1 --ioengine=libaio --direct=1 --gtod_reduce=1 --name=test --filename=random_read_write.fio --bs=4k --iodepth=64 --size=4G --readwrite=randrw --rwmixread=75 > ReadWritePerformance.txt

## added by Cameron on 4/25 to test automatic docker creation
sudo mkdir dockerDir
sudo cd dockerDir
sudo curl -o Dockerfile https://raw.githubusercontent.com/mackpenn/CSC496-TeamMackleMoore/docker/Dockerfile
docker build -t benchmarks .
touch streamOutput.txt
docker run benchmarks ./stream > streamOutput.txt
