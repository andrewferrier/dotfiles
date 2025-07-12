# Dotfiles - Master Cheatsheet

```text
awk     | <https://github.com/learnbyexample/Command-line-text-processing/blob/master/gnu_awk.md>
bash/sh | ~/.config/bash.d/README.md
i3      | ~/.config/i3/config
kitty   | ~/.config/kitty/kitty.conf
lf      | ~/.config/lf/lfrc
make    | <https://makefiletutorial.com>
mutt    | ~/.mutt/muttrc.common
neovim  | ~/.config/nvim/README.md
tmux    | ~/.config/tmux/tmux.conf
zsh     | ~/.config/zsh/README.md
```

## MacOS

```text
caffeinate -i <somecommand> | prevent system from sleeping whilst command is running
Ctrl-1/2/3                  | switch desktop
Cmd-Shift-.                 | toggle hidden file display in Finder
Option-Delete               | delete previous word
```

## Firefox

```text
Cmd-Opt-R   | reader view
Vimium keys | <https://github.com/philc/vimium#keyboard-bindings>
```

## zathura (PDF viewer)

```text
a | zoom out to page
r | rotate
s | zoom to page width
```

## feh (image viewer)

```text
/      | zoom out to show entire image
<up>   | zoom in
<down> | zoom out
<, >   | rotate
```

## mpv

```text
? | Show keys
```

## journalctl

```text
journalctl --since=yesterday                 | output from beginning of yesterday
journalctl --since=-1week                    | output from 1 week ago
journalctl CONTAINER_NAME="docker_container" | output from docker container
journalctl --user -u xyz.service             | output from specific user service
```

## Linux

```text
Ctrl-Backspace                                  | delete previous word

getent hosts <hostname>                         | look up DNS name
hardlink                                        | combine duplicate files using hardlinks
inotifywait -m -r ~/directory                   | watch a directory for changes
lshw -short -sanitize                           | Summarize hardware for selling
lynis                                           | Security audit
pdfunite                                        | combine PDFs on comand line
systemctl reset-failed                          | Remove stray systemctl units/timers
xxd                                             | Hex dump
speaker-test -c 2 -t wav                        | test speaker
Cheese                                          | webcam test
PulseAudio mixer                                | mic test
```

### Linux - Disks and Filesystems

```text
badblocks -b 8192 -wsv /dev/device              | test device for bad blocks (DESTRUCTIVE!)
blkdiscard --secure -v -f /dev/device           | Securely erase SSD
parted mkpart primary ext4 0% 100%              | create a single partition
sdparm --clear=STANDBY --save -S /dev/device    | disable SCSI drive from going to sleep
shred -vz /dev/device                           | Securely erase hard drive

duperemove --hashfile=/tmp/x.hash -r -d /target | de-duplicate
btrfs scrub /target                             | check checksums
```

## Audio file manipulation

```text
eyeD3 --add-image "cover.jpg:FRONT_COVER" test.mp3 | add image to MP3
```

## General Configuration Help

```text
* MacOS - <https://git.herrbischoff.com/awesome-macos-command-line/about/>
```

<!-- vim: set nospell: -->
