# Get started

This repository contains some scripts to start a new computer. To run the scripts
you first need to follow the instructions on the **Base** section 
 
## Base

This section contains a series of steps for my personal setup, like setup ssh keys 
and things like that, this section can be skipped if you don't need to setup this

### Requires manual installation

**cURL**

Install `cURL` from the following URL [http://curl.se/download.html](http://curl.se/download.html)
after downloading the ZIP and unzip the resulting file go to a terminal and execute the following
commands (the version of curl might change, update the `cd` command accordingly)

```bash
cd ~/Downloads/curl-7.86.0
export ARCH=x86_64
export SDK=macosx
export DEPLOYMENT_TARGET=10.8

export CFLAGS="-arch $ARCH -isysroot $(xcrun -sdk $SDK --show-sdk-path) -m$SDK-version-min=$DEPLOYMENT_TARGET"
./configure --host=$ARCH-apple-darwin --prefix $(pwd)/artifacts --with-secure-transport
make -j8
make install
```

**Spark (email client)**

Go to the URL [https://sparkmailapp.com/download](https://sparkmailapp.com/download) download the app and 
follow the installation instructions

**iTerm Profile**

On the `.dotfiles` there is a json with the configuration for the iTerm profile that profile contains the colors
and other useful things for iTerm. In order to configure that open iTerm then go to **Profiles** then **Open Profiles...**
then click on **Edit Profiles**, **Other Actions..** and finally **Import JSON Profiles...**. A finder will be open to select the
type **Cmd + Shift + .** (this will reveal the hidden files) go to your home directory and select `.dotfiles` there select 
`iterm-profile.json` and import that file. Set that as default and delete the other default. Finally restart iTerm

### Installed automatically

Navigate to the following 
[https://github.com/elpic/ansible-personal.git](https://github.com/elpic/ansible-personal.git) 
once there click on the **Code** button and then **Download ZIP**, unzip the file download on your
Downloads dirctory and run the base-install script to install the base required software, to do
that you can follow the instructions bellow 

```bash
cd ~/Downloads/ansible-personal-main
./bin/base-install.sh 
```
