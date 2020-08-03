FROM centos:8
LABEL maintainer="contact@infopen.pro"

ARG ASDF_VERSION="v0.8.0-rc1"
ARG COMMITIZEN_VERSION="v2.0.1"
ARG PRECOMMIT_VERSION="v2.6.0"

ARG ASDF_APPS="terraform:0.13.0-rc1,terraform-docs:v0.9.1,terragrunt:0.23.32,tflint:0.18.0,tfsec:0.24.1"

# Install required dependencies
RUN dnf install -y curl git python3 python3-pip unzip \
  && dnf clean all \
  && git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch ${ASDF_VERSION} \
  && pip3 install commitizen==${COMMITIZEN_VERSION} pre-commit==${PRECOMMIT_VERSION} --user

# Copy scripts
COPY ./scripts /scripts

# Install ASDF managed apps
RUN bash /scripts/install_apps.sh "${ASDF_APPS}"

# Update entrypoint & command
ENTRYPOINT ["/scripts/entrypoint.sh"]
CMD ["bash"]
