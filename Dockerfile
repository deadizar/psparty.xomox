FROM ubuntu:latest
LABEL authors="deadizar"

ENTRYPOINT ["top", "-b"]