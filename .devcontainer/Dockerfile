FROM puppet/pdk:latest

WORKDIR /workspaces/puppet-vault

# [Optional] Uncomment this section to install additional packages.
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends build-essential \
    && pdk bundle
