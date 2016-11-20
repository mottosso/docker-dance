### DANCE

Dockerfile for Ari Shapiro's [DANCE](http://www.arishapiro.com/dance/).

- http://www.arishapiro.com/dance

<br>

### Usage

The Docker image relies on an X11 server and an appropriate display accessible via the `DISPLAY` environment variable.

```bash
$ docker run -ti --rm -e DISPLAY dance
```

| Variable   | Description                             | Example
|:-----------|:----------------------------------------|:----------
| DISPLAY    | Display to which GUI is sent 		   | `myhost:0` or `192.168.0.1:0`

On Windows, this Dockerfile is tested with [VcXsrv](https://sourceforge.net/projects/vcxsrv/).