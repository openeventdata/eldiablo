[![Logo][logo]][logo]

Event data in a box, basically.

##About

The main goal of EL:DIABLO is to overcome [dependency hell](https://en.wikipedia.org/wiki/Dependency_hell)
and make it much easier for the end user to get up and running with event data
coding. Using software designed for development operations allows us to easily
share the setup we use to develop the tools and software for creating and
working with event data. In short, no matter what hardware or operating system
a user chooses, it is possible to replicate our exact event-data coding
platform on that specific configuration. This goal is important to us for two
primary reasons. First, we are striving to make the generation of event data
more open than it has historically been. Things such as copyright and licensing
agreements make it difficult to share source texts for coded event data, but we
**can** make the **process** as transparent as possible. This is especially
important since there are a multitude of seemingly minor choices that go into
event data coding that can have a significant impact on the final product. The
second reason we are pursuing EL:DIABLO as a project is to enable
collaboration. It will no longer be unclear what steps are taken to generate
event data, or what the various moving pieces within the system are. If someone
wishes, for example, to develop a new event coder, they can simply drop that in
to the existing pipeline. The same holds for the various dictionaries,
geocoders, web scrapers, etc. It's like Legos. But for event data.

##Components

On the technical side of things, EL:DIABLO provides the information and scripts
necessary to set up a [virtual machine](https://en.wikipedia.org/wiki/Virtual_machine)
on a user's computer. For those not familiar, this can be thought of as a
computer within a computer. EL:DIABLO relies on [Vagrant](https://www.vagrantup.com/),
and by extension [VirtualBox](https://www.virtualbox.org/), to set up this
virtual environment. These two pieces of software allow for the easy setup and
use of a virtual machine. Thus, two of the files contained within EL:DIABLO are
a `Vagrantfile`, which gives instructions to Vagrant on how to setup the virtual
machine, and `bootstrap.sh`, which is a [shell script](https://en.wikipedia.org/wiki/Shell_script)
that installs the necessary software within the virtual machine.

The EL:DIABLO event coding platform is comprised of two primary applications:
a web scraper and a processing pipeline ([`scraper`](https://github.com/openeventdata/scraper) and
[`phoenix_pipeline`](https://github.com/openeventdata/phoenix_pipeline) specifically). The scraper is a simple web scraper that
makes use of a whitelist of RSS feeds to pull stories from popular news
outlets. The pipeline moves the news stories from storage in a database to the
event coder, such as TABARI or PETRARCH, and outputs event data. More
information about the details of these projects can be found in their
respective documentation, linked to above. If you use the standard
`bootstrap.sh` script provided with EL:DIABLO, the web scraper will run once an
hour, and the pipeline will run once a day at 01:00.

##Setting up

As mentioned above, EL:DIABLO relies on Vagrant and VirtualBox for most of the
heavy lifting. This means that the only things that
a user needs to install on their local machine are these two pieces of
software. The creators of this software describe the install process better
than we can, so a user should look [here](https://www.vagrantup.com/downloads.html)
for Vagrant and [here](https://www.virtualbox.org/wiki/Downloads)
for VirtualBox. Once that software is installed, EL:DIABLO needs to be
downloaded from the [Github repository](https://github.com/openeventdata/eldiablo).
For those familiar with `git`, a `git clone` should work fine. For those
unfamiliar with `git`, it is possible to download the repository as a zip file
as shown in the picture below.

*Note: We've tested this setup on Vagrant 1.6.5*

[![Github][git]][git]

Once this file is downloaded and unzipped, you should use the command line to cd into the
directory and do `vagrant up`. This will take awhile to download the operating system image
(this will only be done once) and then install the relevant software within the virtual
machine. Seriously, this is going to take time; the process hasn't stalled out. Then `vagrant ssh`
to get into the box. You're now in the virtual machine. Overall, this should look something like:

[![Shell][first]][first]

[![Shell][second]][second]

As a note, all of this will create a folder somewhere on your local machine
that contains the operating system images. On OSX it's in the home directory and
named `VirtualBox VMs`. 

To get out of the virtual machine, type `exit`, which will bring you back to your local machine.
There are three methods for ending the Vagrant box: `vagrant suspend`, `vagrant halt`, and
`vagrant destroy`. The main difference between these three is the amount of
system resources used while in the "down" state. If you are completely done
with the virtual machine, and do not wish to keep any of the data, make use of
`vagrant destroy`. Again, this *will remove* all of the data within the virtual
machine and all software will have to be reinstalled. If you wish to just
temporarily bring down the virtual machine, the other two commands should be
explored in the [Vagrant documentation](https://docs.vagrantup.com/v2/getting-started/teardown.html).

##Other Information

Due to the way Vagrant sets up the virtual machine, it is necessary to prepend nearly
every command with `sudo`.

The filepaths in the config file for the `stanford_pipeline` need to be changed
to use absolute paths. For example:

```
cd ~/stanford_pipeline
sudo vim default_config.ini
```

Once in the config, change the `~/` characters to `/home/vagrant/`. 

The `bootstrap.sh` script is specifically configured for use with the Vagrant
box, but with slight modifications can be used on any Linux box (it's what we
use to bootstrap our machines). This means that the script can serve as the
basis for setting up a high-performance computer running EL:DIABLO, an
individual's laptop, etc. 

Currently the virtual machine takes up 2GB of RAM. If the `stanford_pipeline`
starts giving errors, especially errors from Java or CoreNLP, try modifying the
`Vagrantfile` in the directory to have more memory. 

For the two Github repositories, `scraper` and `phoenix_pipeline`, each time
`vagrant up` is run the most recent version of the code is pulled from Github.
If you have a long-running virtual machine and wish to obtain the latest code,
you can `cd` into the appropriate directory and run `sudo git pull`. 

[git]: http://i.imgur.com/YTT6Ppy.png "Github example"
[first]: http://i.imgur.com/UJtjy3N.png "Terminal example"
[second]: http://i.imgur.com/206UtDs.png "Second terminal example"
[logo]: https://i.imgur.com/3R7gtyr.png "EL:DIABLO logo"
