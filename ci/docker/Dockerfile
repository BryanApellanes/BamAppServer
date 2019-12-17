FROM bamapps/bamweb-runtime:0.0.2

WORKDIR /opt/bam/content

COPY . ./

ENV ASPNETCORE_ENVIRONMENT=DEV
ENV PATH "$PATH:/root/.bam/toolkit/ubuntu.16.10-x64/bamweb"
ENTRYPOINT [ "/opt/bam/content/serve.sh" ]

