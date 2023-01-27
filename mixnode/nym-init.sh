#!/usr/bin/env bash
while getopts h:i:l: option
do
    case "${option}"
        in
        h) HOST=${OPTARG};;
        i) ID=${OPTARG};;
        l) LAYER=${OPTARG};;
    esac
done

echo "Checking for pem files"
if [ ! -f $HOME/.nym/mixnode/debaser/data/private_sphinx.pem ] || [ ! -f $HOME/.nym/mixnode/debaser/data/public_sphinx.pem ]; then
    echo "Missing pem files, running init"
    nym-mixnode init --host ${HOST} --id ${ID} --layer ${LAYER}
fi
if [ -f $HOME/.nym/mixnode/debaser/data/private_sphinx.pem ] && [ -f $HOME/.nym/mixnode/debaser/data/public_sphinx.pem ]; then
    echo "Pem files found"
fi
