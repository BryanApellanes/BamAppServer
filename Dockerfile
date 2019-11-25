FROM bryanapellanes/bamweb-runtime:latest

WORKDIR /root/.bam/content

COPY . ./

ENV ASPNETCORE_ENVIRONMENT=DEV
ENV PATH "$PATH:/root/.bam/toolkit/ubuntu.16.10-x64/bamweb"
ENTRYPOINT [ "./serve.sh" ]
#ENTRYPOINT [ "bamweb", "/S", "/content:/root/.bam/content", "/verbose" ]

