# Get Started

This application is used to install the different software and the different versions of each. When you
add a new software or version you need to recompile the asdf binary (see [hacking](#hacking))

# Hacking

In order to generate a new version of the project you need to have docker installed after that you can run 
the following command:

```bash
$ alias bashly='docker run --rm -it --user $(id -u):$(id -g) --volume "$PWD:/app" dannyben/bashly'
```

After that change the code and run the following command in the root folder (asdf)

```bash
$ bashly generate
```
