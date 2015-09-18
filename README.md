# chef-bioinf-worker

Chef cookbook which sets up many common bioinformatics tools.



## Installation

### Prerequisites

Install the Chef Development Kit by downloading it from the
[Chef download site](https://downloads.chef.io/chef-dk/). In Ubuntu change to
the directory, the Chef DK package is stored. Then enter

    sudo dpkg -i chefdk_*.deb
    
Clone this repository by entering

    mkdir cookbooks
    (cd cookbooks; git clone https://github.com/joergen7/chef-bioinf-worker.git)

### Installing locally

You can install the bioinformics tools locally by entering
    
    sudo chef-client -z -r "chef-bioinf-worker::default"
    
### Creating a VM with bioinformatics tools

Alternatively, you can create a VM with bioinformatics tools by letting kitchen
create a test instance. Make sure, vagrant and virtualbox are installed. In
Ubuntu you can install both by entering

    sudo apt-get install vagrant virtualbox

Now enter the directory of the chef-bioinf-worker cookbook and let kitchen
create the test instance.

    cd cookbooks/chef-bioinf-worker
    kitchen converge
    
Log into your machine by entering

    kitchen login
