FROM bamapps/bamweb-runtime:0.0.1

WORKDIR /opt/bam/content

COPY . ./

ENV ASPNETCORE_ENVIRONMENT=DEV
ENV PATH "$PATH:/root/.bam/toolkit/ubuntu.16.10-x64/bamweb:/root/.local/bin"

