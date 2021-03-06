# Dotfiles - Master Cheatsheet

    awk         | <https://github.com/learnbyexample/Command-line-text-processing/blob/master/gnu_awk.md>
    bash        | ~/.config/bash.d/README.md
    kitty       | ~/.config/kitty/kitty.conf
    mutt        | ~/.mutt/muttrc.common
    neovim      | ~/.config/nvim/README.md
    qutebrowser | ~/.config/qutebrowser/config.py
    ranger      | ~/.config/ranger/rc.conf
    zsh         | ~/.config/zsh/README.md

## Firefox

    Cmd-Opt-R   | reader view
    Vimium keys | <https://github.com/philc/vimium#keyboard-bindings>

## Slack

    Cmd-K | Jump to existing conversation
    Cmd-N | Start new conversation

## zathura (PDF viewer)

    a | zoom out to page
    r | rotate
    s | zoom to page width

## feh (image viewer)

    /      | zoom out to show entire image
    <up>   | zoom in
    <down> | zoom out
    <, >   | rotate

## vimpc (mpd client)

    f | Find song playing now

## journalctl

    journalctl --since=yesterday                 | output from beginning of yesterday
    journalctl --since=-1week                    | output from 1 week ago
    journalctl CONTAINER_NAME="docker_container" | output from docker container

## Linux

    getent hosts <hostname> | look up DNS name
    pdfunite                | combine PDFs on comand line

## Audio file manipulation

    eyeD3 --add-image "cover.jpg:FRONT_COVER" test.mp3 | add image to MP3

<!-- vim: set nospell: -->
