FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive

RUN set -ex; \
  apt update; \
  apt install -y apt-utils; \
  apt install -y  --no-install-recommends \
    gcc-multilib libc6-dev build-essential \
    git python3 python3-pip qemu-system-x86; \
  pip3 install --no-cache-dir setuptools ; \
  pip3 install --no-cache-dir pyyaml requests gitpython parse lorem; \
  apt autoremove -y; \
  find / -name .cache -exec 'rm' '-rf' '{}' ';'; \
  rm -rf /var/cache/apt/*; \
  rm -rf /var/lib/apt/lists/*; \
  useradd --create-home --user-group -u 1000 anubis; \
  mkdir -p /anubis; \
  chown anubis:anubis -R /anubis; \
  mkdir -p /anubis/student; \
  chmod 770 /anubis/student;

ENV PATH=/bin:/sbin:/usr/bin:/usr/local/bin:/usr/lib/gcc/x86_64-linux-gnu/10
ENV HOME=/home/anubis
USER anubis
WORKDIR /anubis
COPY pipeline.py utils.py meta.yml assignment.py /anubis/

ENTRYPOINT ["/usr/bin/python3", "pipeline.py"]
