FROM bryanapellanes/bamweb:latest

WORKDIR /root/.bam/content

COPY . ./

ENV ASPNETCORE_ENVIRONMENT=DEV
ENTRYPOINT [ "./serve.sh" ]

