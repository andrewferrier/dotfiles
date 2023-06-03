#!/usr/bin/env bash

if (command -v pass >/dev/null 2>&1); then
    export PASSWORD_STORE_DIR=${HOME}/pass
fi
