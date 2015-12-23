# chef-bioinf-worker

Chef cookbook which sets up many common bioinformatics tools.



## Prerequisites

Install the following packages:

- [git](https://git-scm.com/)
- [Chef Development Kit](https://downloads.chef.io/chef-dk/)
- [GATK](https://www.broadinstitute.org/gatk/download/)

If you want to set up a VM to test Cuneiform these additional packages are required:

- [VirtualBox](https://www.virtualbox.org/)
- [Vagrant](https://www.vagrantup.com/)


Under Ubuntu you can install the ChefDK by entering on the command line

    sudo dpkg -i chefdk_*.deb


## Building a VM with kitchen

This section describes how to set up a bioinformatics worker in a Virtual
Machine (VM). To do this, it does not matter whether you are running Linux,
Mac OS, or Windows. However, if you are running an Ubuntu and want to set up
the workflow locally (without creating a VM), see Section Building locally.

To build a VM from this cookbook for the first time, change your git
base directory and enter the following:

    git clone https://github.com/joergen7/chef-bioinf-worker.git

After cloning the git repository, download the [GATK binaries](https://www.broadinstitute.org/gatk/download/) and place them
in the files folder so that your cookbook folder contains a file
'files/GenomeAnalysisTK-3.5.tar.bz2'. Now enter the cookbook folder and
converge the VM.

    cd chef-bioinf-worker
    kitchen converge
    
You can log into the newly built VM by entering

    kitchen login
    
You can drop the VM by entering

    kitchen destroy

## Building locally

This section describes how to set up this workflow locally without the indirection
of a VM. If you want to try out this workflow in a VM first see Section Building a VM with kitchen.

To install this cookbook locally, create a directory "cookbooks", clone the cookbook
into it and run the chef client:

    mkdir cookbooks
    cd cookbooks
    git clone https://github.com/joergen7/chef-bioinf-worker.git

After cloning the git repository, download the [GATK binaries](https://www.broadinstitute.org/gatk/download/) and place them
in the files folder so that your cookbook folder contains a file
'files/GenomeAnalysisTK-3.5.tar.bz2'. Now enter the cookbook folder and
converge the VM.

    cd ..
    sudo chef-client -z -r "chef-bioinf-worker::default"
    
