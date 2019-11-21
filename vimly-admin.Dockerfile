FROM bryanapellanes/bamweb:latest

RUN apt-get update \
    && apt-get install -y --no-install-recommends git-core curl build-essential openssl libssl-dev unzip \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /opt/bam

WORKDIR /opt/bam

COPY . ./

RUN mv ./_ssh/ ./.ssh \
    && git clone git@bitbucket.org:bsiprojectjedan/vimly-admin.git /opt/bam/content

WORKDIR /opt/bam/content

RUN ./browserfy.sh

ENV ASPNETCORE_ENVIRONMENT=DEV
ENV PATH "$PATH:/root/.bam/toolkit/ubuntu.16.10-x64/bamweb"
ENTRYPOINT [ "bamweb", "/S", "/content:/opt/bam/content", "/verbose"]

