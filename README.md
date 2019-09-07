# payetools-docker
A dockerfile for running HMRC Payetools in a reliable linux container

## Why

Because PayeTools has unreliable dependencies on latest linux distros which are a pain to fix.

This is a reliable build that will work whatever linux / osx distro / os you are on.

## Building

### Basic build

navigate to this directory then:

```
docker build --rm -t payetoolsrti:latest ./
```

The current version *(07/09/2019)* is `19.1.19116.1393` but you can build with a newer version by adding the variable
`rtiversion` to the build command:

```
RTI_VERSION=19.1.19116.1393 docker build --rm --build-arg rtiversion=$RTI_VERSION -t
payetoolsrti:$RTI_VERSION && docker tag payetoolsrti:$RTI_VERSION payetoolsrti:latest
```

## Running

To help with running on X11 / Wayland, i've created the script [runPayeTools.sh](./runPayeTools.sh) which
will execute the gui version.


However you may prefer to execute `rti.linux` with the `-a` flag which will run a server which you can access
at [http://127.0.0.1:46729](http://127.0.0.1:46729). For me, this is preferable as you can use any browser
you like along with password managers etc.

**Note that their server seems to only work at the hostname `127.0.0.1` so you can't use `localhost` or another ip
address. It has to be mapped to `127.0.0.1` on your host machine**

## Data

The script maps the directory `HMRC` in your home directory inside the container so you can persist your data
/ store backups of the sqlite db.


## License

MIT
