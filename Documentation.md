## Benchmark Choices:
* CPU - PXZ
* HPC - Linpack
* Memory Bandwidth - Stream
* Random Memory Access - RandomAccess
* Network Bandwidth - nuttcp
* Network Latency - netperf
* Block I/O - fio
* Redis
* MySQL

## Selected Benchmarks: 
#### High Performance Computing (HPC) - Linpack
* Linpack is a benchmark which measures high performance computing speed by solving dense linear equations in a 64 bit format. It tests for the both the accuracy of the platform’s solution as well as the time it took to reach it.
* While Linpack’s best-case performance can vary based on several factors, the benchmark’s contents remain “scalable in the sense that their parallel efficiency is maintained constant with respect to the per processor memory usage.”
* Linpack’s performance on Docker and Linux are similar, but performance departs significantly when using untuned KVM. As stated in the article, the Linpack test utilized was based on the Intel Math Kernel Library, which optimizes its operations based on the system’s available floating point resources and cache topology. Without tuning (pinning virtual CPUs to their physical counterparts and exposing the non-virtual system topology), Linpack cannot optimize and thus runs less efficiently.
* If KVM is configured to faithfully reflect system topology, however, the performance is nearly par with Docker and native Linux. As the authors report, this is expected of running a benchmark which is capable of taking advantage of hardware details, and this is instructive as it can illustrate the performance cost of different methods of virtualization.


#### Block I/O - fio
* Fio is the benchmark used to test the overhead, or cost, of virtualizing block storage. Block storage is used in cloud computing to provide high performance and strong consistency, according to the IBM Research Report.
Storage configurations for fio: See Figure 4
How fio works: The tool simulates a given I/O workload without resorting to writing a tailored test case repeatedly for specific workloads.
* Fio is flexible enough to simulate multiple different test cases, such as the examples given in its documentation: “You could have someone dirtying large amounts of memory in an memory mapped file, or maybe several threads issuing reads using asynchronous I/O.”
* Fio will create threads and processes to do a particular type of I/O action, taking given parameters into consideration.
* In the below case, fio is used to run several tests against a 16GB file stored on the SSD to test the block storage performance.
* In measuring the sequential read/write performance of the storage over 60 seconds, there appears to be barely any difference between Native, Docker, and KVM when it comes to their throughput. However, KVM had a much larger performance variance than the other two, almost four times as much according to the article.
![alt text](https://github.com/mackpenn/CSC496-TeamMackleMoore/blob/master/CC%20Pro%201%20(2).PNG "Graph 1")
* The differences are more apparent in the graph plotting the random read/write/mixed performance of the storage. Native and Docker yet again have barely any differences in their IOPS (I/O Operations per Second), while KVM only provides half the operations per second that they do.
    - KVM’s is halved because each I/O operation must go through QEMU, or  a Quick Emulator.


## Links

#### Linpack
* http://www.netlib.org/linpack/
* https://www.instructables.com/id/How-to-benchmark-an-intel-CPU/
* https://hub.docker.com/r/elreyes/linpack
* https://hub.docker.com/r/stuts/intel-linpack-64bit/


#### Fio
* https://github.com/axboe/fio
* https://fio.readthedocs.io/en/latest/
* https://hub.docker.com/r/clusterhq/fio-tool/
* https://linux.die.net/man/1/fio
* https://dotlayer.com/how-to-use-fio-to-measure-disk-performance-in-linux/
