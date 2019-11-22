FROM bryanapellanes/bamweb-runtime:latest

WORKDIR /root/.bam/content

COPY . ./

RUN ./browserify.sh

ENV ASPNETCORE_ENVIRONMENT=DEV
ENV PATH "$PATH:/root/.bam/toolkit/ubuntu.16.10-x64/bamweb"

