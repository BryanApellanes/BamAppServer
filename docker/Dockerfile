# Build
FROM microsoft/dotnet:sdk AS build-env

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

# Runtime
FROM microsoft/dotnet:aspnetcore-runtime

RUN apt-get update \
    && apt-get install -y --no-install-recommends curl \
    && apt-get install -y git \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/* 

WORKDIR /root

COPY --from=build-env /root/.bam ./

ENV ASPNETCORE_ENVIRONMENT=PROD
ENTRYPOINT [ "bamweb", "/S", "/content:/root/.bam/content", "/verbose"]

