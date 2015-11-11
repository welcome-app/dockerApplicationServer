#!/usr/bin/env bash
# Inspired by: https://gist.github.com/neilellis/2d25f0ade3d6cae6f7c9
# Expects one argument the name of the production stack file
#
# Requires these environment variables to be set
#
# CLOUDFLARE_DOMAIN - root domain of your app, e.g. example.com
# CLOUDFLARE_KEY - your Cloudflare API key
# CLOUDFLARE_EMAIL - your Cloudflare email address e.g. fred@example.com
# PROJECT_NAME - a short name for your project e.g. example
# TUTUM_USERNAME - your Tutum username, using tutum file instead
# TUTUM_PASSWORD - your Tutum password
# CLUSTER_SIZE - the initial cluster size (default 1)
#
# NB: The script assumes you have a loadbalancer service within your stack called 'lb'
#     You should have created a node cluster called ${PROJECT_NAME}
#     It is assumed that you normally have one node in the cluster and expand to 2 during deployment.

set -eu
cd $(dirname $0)

#cluster_normal_size=${CLUSTER_SIZE:-1}
#cluster_expanded_size=$(( cluster_normal_size * 2 ))
project=welcome-api
state=man
#alt_state=


if ! which tutum >/dev/null
then
    echo "Please install Tutum CLI using 'sudo -H pip install tutum'"
    exit 1
fi

#if ! which cfcli
#then
#    echo "Please install Cloudflare CLI using 'npm install -g cloudflare-cli'"
#    exit 1
#fi


if (( $# == 0))
then
    echo "Usage: $0 <stack-file>"
    exit 1
fi

if tutum stack list | grep ${project}-${state} 
then
    echo "We have a stack running, update"
    tutum stack update ${project}-${state} --sync -f $1
    echo "Redeploy"
    tutum stack redeploy ${project}-${state} --sync
    echo "Done"
else
    echo "We have to create one"
    tutum stack up -n ${project}-${state} --sync -f $1
fi
