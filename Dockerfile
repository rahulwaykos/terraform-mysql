FROM golang:alpine

ENV TERRAFORM_VERSION=0.10.0

RUN apk add --update git bash openssh make

ENV TF_DEV=true
ENV TF_RELEASE=true

WORKDIR $GOPATH/src/github.com/hashicorp/terraform
RUN git clone https://github.com/hashicorp/terraform.git ./ && \
    git checkout v${TERRAFORM_VERSION} && \
    /bin/bash scripts/build.sh
    
RUN mkdir -p $GOPATH/src/github.com/terraform-providers && cd $GOPATH/src/github.com/terraform-providers && \
    git clone https://github.com/terraform-providers/terraform-provider-mysql

WORKDIR $GOPATH/src/github.com/terraform-providers/terraform-provider-mysql
RUN  make build

WORKDIR $GOPATH
ENTRYPOINT ["terraform"]
