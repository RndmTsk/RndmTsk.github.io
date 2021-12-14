# Generation

A static site generation tool written in Swift.


## Building

```
$ docker build . --tag generation
```

## Running

```
$ docker run --rm --mount type=bind,source=<local_path>,target=/code generation <args>
```