#!/usr/bin/env bash

# ~/.bashrc: executed by bash(1) for non-login shells.

if [[ $- != *i* ]]; then
    # If not running interactively, exit
    return
fi

for file in "${HOME}"/.config/sh.d/*.sh; do
    # shellcheck source=/dev/null
    source "${file}"
done

for file in "${HOME}"/.config/sh-local.d/*.sh; do
    # shellcheck source=/dev/null
    source "${file}"
done

for file in "${HOME}"/.config/bash.d/*.bashrc; do
    # shellcheck source=/dev/null
    source "${file}"
done
