#!/usr/bin/env bash

if (command -v ffmpeg >/dev/null 2>&1); then
    function ffmpeg-to-audioonly-lowres {
        INPUT=${1?Specify input file}
        OUTPUT="${2:-${INPUT%.*}-audioonly-lowres.mp3}"

        ffmpeg -i "${INPUT}" -vn -codec:a libmp3lame -q:a 7 "${OUTPUT}"
    }

    function ffmpeg-to-all-lowres {
        INPUT=${1?Specify input file}
        OUTPUT="${2:-${INPUT%.*}-lowres.mp4}"

        ffmpeg -i "${INPUT}" -filter:v scale="trunc(oh*a/2)*2:480" -c:v libx265 -crf 28 -codec:a libmp3lame -q:a 7 "${OUTPUT}"
    }

    function ffmpeg-to-mp4-container {
        INPUT=${1?Specify input file}
        OUTPUT="${2:-${INPUT%.*}.mp4}"

        ffmpeg -i "${INPUT}" -c:v copy -c:a aac "${OUTPUT}"
    }
fi
