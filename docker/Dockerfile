FROM bryanapellanes/bamweb:latest

WORKDIR /root

COPY . ./

RUN mv ./_ssh/ ./.ssh \
    && git clone git@bitbucket.org:bsiprojectjedan/vimly-admin.git /root/.bam/content

WORKDIR /root/.bam/content

RUN npm install

ENV ASPNETCORE_ENVIRONMENT=DEV
ENTRYPOINT [ "./serve.sh" ]

