# Dotfiles - Master Cheatsheet

    awk         | <https://github.com/learnbyexample/Command-line-text-processing/blob/master/gnu_awk.md>
    bash/sh     | ~/.config/bash.d/README.md
    i3          | ~/.config/i3/config
    kitty       | ~/.config/kitty/kitty.conf
    lf          | ~/.config/lf/lfrc
    mutt        | ~/.mutt/muttrc.common
    neovim      | ~/.config/nvim/README.md
    zsh         | ~/.config/zsh/README.md

## Useful commands

    xxd | Hex dump

## MacOS

    caffeinate -i <somecommand> | prevent system from sleeping whilst command is running
    Ctrl-1/2/3                  | switch desktop
    Cmd-Shift-.                 | toggle hidden file display in Finder

## Firefox

    Cmd-Opt-R   | reader view
    Vimium keys | <https://github.com/philc/vimium#keyboard-bindings>

## zathura (PDF viewer)

    a | zoom out to page
    r | rotate
    s | zoom to page width

## feh (image viewer)

    /      | zoom out to show entire image
    <up>   | zoom in
    <down> | zoom out
    <, >   | rotate

## journalctl

    journalctl --since=yesterday                 | output from beginning of yesterday
    journalctl --since=-1week                    | output from 1 week ago
    journalctl CONTAINER_NAME="docker_container" | output from docker container
    journalctl --user -u xyz.service             | output from specific user service

## Linux

    getent hosts <hostname> | look up DNS name
    pdfunite                | combine PDFs on comand line

## Audio file manipulation

    eyeD3 --add-image "cover.jpg:FRONT_COVER" test.mp3 | add image to MP3

## General Configuration Help

    * MacOS - <https://git.herrbischoff.com/awesome-macos-command-line/about/>

<!-- vim: set nospell: -->
