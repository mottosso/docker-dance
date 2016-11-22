### DANCE

Dockerfile for Ari Shapiro's [DANCE](http://www.arishapiro.com/dance/).

- http://www.arishapiro.com/dance

<br>

### Usage

The Docker image relies on an X11 server and an appropriate display accessible via the `DISPLAY` environment variable.

```bash
$ cd docker-dance
$ docker build -t dance .
$ docker run -ti --rm -e DISPLAY dance
```

> Building takes about 10 minutes on a 2-core machine of 2 gb of memory.

![image](https://cloud.githubusercontent.com/assets/2152766/20515824/4e64469c-b08b-11e6-82f0-55c9e1d83440.png)

| Variable   | Description                             | Example
|:-----------|:----------------------------------------|:----------
| DISPLAY    | Display to which GUI is sent 		   | `myhost:0` or `192.168.0.1:0`

On Windows, this Dockerfile is tested with [VcXsrv](https://sourceforge.net/projects/vcxsrv/).