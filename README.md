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

### Installed automatically

Navigate to the following
[https://github.com/elpic/ansible.git](https://github.com/elpic/ansible.git)
once there click on the **Code** button and then **Download ZIP**, unzip the file download on your
Downloads dirctory and run the base-install script to install the base required software, to do
that you can follow the instructions bellow

```bash
cd ~/Downloads/ansible-main
./bin/base-install.sh
```

## Run the scripts

Since the only version of python that is installed is the one that is on your system, you need to
export that to the path so the system knows about the python executable

```shell
# NOTE: depending on the version of python the command might change
$ export PATH=$PATH:$HOME/Library/Python/3.9/bin
```

After that you can run the following line

```shell
$ ./bin/setup.sh
```
