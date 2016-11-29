FROM alpine:3.4

# from https://github.com/frol/docker-alpine-python3
RUN apk add --no-cache python3 && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    rm -r /root/.cache

# Copy the application's requirements.txt and run pip to install all
# dependencies into the virtualenv.
ADD requirements.txt /code/requirements.txt
RUN pip install -r /code/requirements.txt

ADD . /code
WORKDIR /code

CMD ["gunicorn", "todolist:app", "-w","2","-b",":8000"]