FROM microsoft/dotnet:aspnetcore-runtime

RUN apt-get update \
    && apt-get install -y --no-install-recommends curl \
    && apt-get install -y git \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/* 

RUN mkdir -p /root/.bam

WORKDIR /root 

COPY . ./

RUN mv ./_ssh/ ./.ssh \
    && git clone git@bitbucket.org:bsiprojectjedan/vimly-admin.git ./.bam/content

WORKDIR /root/.bam/content

RUN ./setup.sh

ENV ASPNETCORE_ENVIRONMENT=PROD
ENTRYPOINT [ "bamweb", "/S", "/content:/root/.bam/content", "/verbose"]

