#!/bin/env bash

if [ -z "${GABRIEL+x}" ]; then
    export GABRIEL=42
fi
echo "GABRIEL : $GABRIEL"