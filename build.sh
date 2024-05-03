#!/bin/bash

set -e

RTI_VERSION="${1:-24.1.24086.542}"

echo "Building for RTI Version $RTI_VERSION"
docker build --tag="payetools:$RTI_VERSION" --tag="latest" --build-arg="$RTI_VERSION" .