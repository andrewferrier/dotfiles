#!/usr/bin/env bash

if (command -v ffmpeg >/dev/null 2>&1); then
    function ffmpeg-extract-audio-lowres {
        INPUT=$1
        OUTPUT="${2:-${INPUT%.mkv}.mp3}"

        ffmpeg -i "${INPUT}" -vn -codec:a libmp3lame -qscale:a 7 "${OUTPUT}"
    }
fi
