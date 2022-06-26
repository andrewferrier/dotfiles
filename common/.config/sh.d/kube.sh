#!/usr/bin/env bash

if (command -v kubectl >/dev/null 2>&1); then
    alias kubectl-run-debian-bash='kubectl run --rm -i --tty --image=debian debian'
    alias kubectl-run-ibm-alpine-bash='kubectl run --rm -i --tty --image=icr.io/armada-master/alpine:latest alpine'
    alias kubectl-run-ibm-alpine-node-bash='kubectl debug node/$(kubectl get nodes | head -2 | tail -1 | cut -f1 -d" ") -i --tty --image=icr.io/armada-master/alpine:latest'

    function kubectl-context-select {
        kubectl config use-context "$(kubectl config get-contexts -o name | fzf)"
    }

    function kubectl-context-delete {
        kubectl config get-contexts -o name | fzf -m | xargs -n1 kubectl config delete-context
    }

    function kubectl-namespace-select {
        kubectl config set-context --current --namespace "$(kubectl get ns -o name | fzf -d/ --with-nth=2 | cut -d/ -f2)"
    }
fi
