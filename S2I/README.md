# Multi-stage build for a Java App

## Build the Docker image

```bash
docker build -t s2i .
```

### Run the Docker image

```bash
docker run -t --rm s2i
```
