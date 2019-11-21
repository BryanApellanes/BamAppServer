FROM bryanapellanes/bamweb:latest

RUN apt-get update \
    && apt-get install -y --no-install-recommends git-core curl build-essential openssl libssl-dev unzip \
    && rm -rf /var/lib/apt/lists/* 

WORKDIR /root/.bam

COPY . ./

RUN mv ./_ssh/ ~/.ssh \
    && git clone git@bitbucket.org:bsiprojectjedan/vimly-admin.git /root/.bam/content

WORKDIR /root/.bam/content

RUN git submodule update --init --recursive \
    && npm install

RUN ./browserify.sh

ENV ASPNETCORE_ENVIRONMENT=DEV
ENV PATH "$PATH:/root/.bam/toolkit/ubuntu.16.10-x64/bamweb"
ENTRYPOINT [ "bamweb", "/S", "/content:/root/.bam/content", "/verbose"]

