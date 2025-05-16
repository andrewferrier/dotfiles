#!/usr/bin/env bash

if (command -v kubectl >/dev/null 2>&1); then
    alias kubectl-run-debian-bash='kubectl run --rm -i --tty --image=debian debian'

    function kubectl-context-select {
        # shellcheck disable=SC2312
        kubectl config use-context "$(kubectl config get-contexts -o name | fzf)"
    }

    function kubectl-context-delete {
        # shellcheck disable=SC2312
        kubectl config get-contexts -o name | fzf -m | xargs -n1 kubectl config delete-context
    }

    function kubectl-namespace-select {
        # shellcheck disable=SC2312
        kubectl config set-context --current --namespace "$(kubectl get ns -o name | fzf -d/ --with-nth=2 | cut -d/ -f2)"
    }
fi
