# Performance Evaluation: KVM vs. Docker
## Group 8: Brandon Moore, Cameron Moore, MacKenzie Pennington
## CSC 496: Topics in Complex Systems - Cloud Computing
## 30 April 2019

### Introduction
In 2014, IBM’s Research Division published a paper titled “An Updated Performance Comparison of Virtual Machines and Linux Containers” comparing the benchmarks between KVM, Docker, and Native Linux. Their conclusion was that Docker performed better than KVM across the board. However, the writers believe that Docker had reached its peak 2014. We are interested in seeing if KVM has caught up or improved in these five years. In this project, we aim to re-test the paper’s question, and see if a major difference appears between Docker and KVM.

### Current Progress
The two benchmarks we selected to focus on were Stream and Fio. Stream tests memory bandwidth on each machine, while Fio tests the Block I/O performance. Using the cluster-template repository from Dr. Ngo’s github, we began to build our profile Python file and shell scripts. The virtual machine was set up with a Raw PC node, and 4 nodes were created out of it (one head, three workers). For the current deliverable, both KVM and Docker run on the head node, but we do have plans to assign each virtual machine to a different worker node.

We created shell scripts for installing both Docker and KVM. The script “install_kvm.sh” simply runs the software installation, the creation of the virtual machine titled “test”, and the installation/set-up of Fio and Stream. We considered creating a kickstarter file to fully automate the setup of the virtual machine. This would have allowed complete automation of running the benchmarks on KVM. However, instead of focusing our time into automation, we decided to put more emphasis on the performance evaluation and comparison itself. We now set up the test virtual machine manually through the command line GUI, and login to run the tests ourselves. Automation was simpler to perform in the “install_docker.sh” script. It installs Docker, uses Dockerfiles to completely configure the virtual machine and benchmark tests, and prints the Stream and Fio tests out into separate text files.

To stay as true to IBM’s tests as possible, we did our very best to match the resources that they allocated to their virtual machines. They used a total of 256GB of RAM, a total of 16 cores with HyperThreading, and 32 vCPUs to each virtual machine. By the end of our project, we hope to be running benchmarks against KVM, Docker, Native Linux, and Singularity, so we allocated 64GB of RAM to each virtual machine.

### Self-Assessment

The goals of the second deliverable were to be able to install Docker and KVM, build the benchmarks inside their virtual platforms, and perform an in-class demonstration of the selected benchmarks on KVM. At this point in time, we believe that we were able to adequately meet these expectations.

We did meet quite a few challenges throughout this project. At first, we planned to test high-performance computing (HPC) with the Linpack benchmark. After a lot of research, trial, and error, we could not figure out how to properly install and configure the tests in KVM or Docker. We decided to switch our selected benchmark to Stream to resolve this, which installed easily and was much more possible to test completely within the given amount of time.

Another challenge we faced was in regard to resource allocation to the individual virtual machines. We struggled with understanding where to allocate the resources and exactly how much. Once we understood to refer to the paper and use the maximum amount of resources possible, this became a little easier. However, we were trying to configure the Raw PC nodes at first, which apparently configure themselves. Once we figured this out, we were confident with KVM’s configuration as it is all done within the installation of the virtual machine. Yet we are still unsure of whether or not we configured Docker correctly. We believe that Docker automatically allocates the maximum system resources as it can, but this is something we are still trying to confirm. Finally, we tried to allocate too much to the tests themselves, which will be explained in the next challenge. 

The biggest challenge for our group was configuring the tests on each VM to work properly. Fio was giving us quite a bit of difficulty - KVM specifically kept crashing with no error message after the initial VM setup. We found eventually that we had to scale back the size of the block storage device from 512MB to 256MB on the random read and random write tests, as well as the number of jobs to test against from four to two. The random mixed tests only required to reduce the number of jobs to two, so we kept the size at 512MB. Luckily, Stream was fairly straightforward and easy to configure.

### Conclusion

Overall, we are working at a good pace through this assignment. We have met each deliverable on time with minor setbacks and errors, and we believe we will continue to stay on track for the third and final deliverable. According to our tests, KVM has improved over the past five years as predicted, surpassing Docker in block I/O operation speed and meeting Docker in memory bandwidth. We are a little suspicious of how much KVM is exceeding Docker in block I/O operation speed, but we believe this will be resolved after confirming Docker’s resource allocation. With that being said, we plan to accomplish the following moving forward:

* Incorporate Singularity and evaluate its performance against the selected benchmarks
* Run the selected benchmarks on Native Linux and compare its performance to the virtual machines
* Separate each machine to different nodes - Native on the head node and each virtual machine on the worker nodes
* Determine more definitely if Docker is using the maximum amount of resources possibly, further validating our tests
* Finalize whether or not KVM’s Fio tests are supposed to surpass Docker’s as far as our tests show it does
	
 
 We believe we will meet all of the above expectations by the due date of the third deliverable. We hope to use the feedback from our presentation and the knowledge we gain from other presentations to further improve our project and our overall understanding of Cloud Computing.
