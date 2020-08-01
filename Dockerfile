FROM centos:8
LABEL maintainer="contact@infopen.pro"

ARG ASDF_VERSION="v0.8.0-rc1"
ARG ASDF_APPS="terraform:0.13.0-rc1,terragrunt:0.23.32,tflint:0.18.0,tfsec:0.24.1"

# Install required dependencies
RUN dnf install -y curl git python3 python3-pip unzip \
  && git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch ${ASDF_VERSION} \
  && echo '. $HOME/.asdf/asdf.sh' >> /root/.bashrc \
  && echo 'export PATH=~/.local/bin:$PATH' >> /root/.bashrc \
  && pip3 install pre-commit --user

# Install ASDF managed apps
COPY install_apps.sh install_apps.sh
RUN bash install_apps.sh "${ASDF_APPS}"
