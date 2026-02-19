#!/usr/bin/env bash

set -o noclobber
set -o noglob
set -o nounset
set -o pipefail

IFS=$'\n'

FILE_PATH="${1}"
WIDTH="${2:-80}"
HEIGHT="${3:-30}"
HORIZ_POS="${4:-1}"
VERT_POS="${5:-1}"

DEFAULT_IMAGE_WIDTH=1024

IMAGE_CACHE_PATH="/tmp/lf/preview"
mkdir -p "$IMAGE_CACHE_PATH"

FILE_BASENAME=$(basename -- "${FILE_PATH}")
FILE_EXTENSION_LOWER="$(printf "%s" "${FILE_BASENAME##*.}" | tr '[:upper:]' '[:lower:]')"
FILE_EXTENSION_FULL_LOWER=$(printf "%s" "${FILE_BASENAME#*.}" | tr '[:upper:]' '[:lower:]')
FILE_PATHONLY=${FILE_PATH%/*}

if [[ ${OSTYPE} == darwin* ]]; then
    DRAWIO=/Applications/draw.io.app/Contents/MacOS/draw.io
fi

if (command -v batcat &>/dev/null); then
    BAT=("batcat" "--color=always")
else
    BAT=("bat" "--color=always")
fi

if (command -v grealpath &>/dev/null); then
    REALPATH=grealpath
else
    REALPATH=realpath
fi

uid() {
    stat -- "$(readlink -f "$1" || true)" | sha256sum | cut -d' ' -f1
}

THUMBNAIL="$IMAGE_CACHE_PATH/$(uid "$FILE_PATH").png"

display_image() {
    # shellcheck disable=SC2154
    if [[ "$lf_user_view" == "default" ]]; then
        # Exiting with 1 disables preview cache, forcing cleaning
        kitty +icat --transfer-mode file --stdin no --scale-up --place "${WIDTH}x${HEIGHT}@${HORIZ_POS}x${VERT_POS}" "${1}" </dev/null >/dev/tty && exit 1
    fi
}

invoke_exiftool() {
    exiftool -g \
        '--Balance*' \
        '--Blue*' \
        '--Compatible*' \
        '--Copyright*' \
        '--Create*' \
        '--Current*' \
        '--Directory' \
        '--Emphasis*' \
        '--Exif*' \
        '--ExifTool*' \
        '--Graphics*' \
        '--Green*' \
        '--Handler*' \
        '--Intensity*' \
        '--MS*' \
        '--Matrix*' \
        '--Media*' \
        '--Minor*' \
        '--Modify*' \
        '--Movie*' \
        '--Op*' \
        '--Original*' \
        '--Poster*' \
        '--Preferred*' \
        '--Preview*' \
        '--Red*' \
        '--Selection*' \
        '--Source*' \
        '--Time*' \
        '--Track*' \
        '--Zip*' \
        '--Warning*' \
        '--White*' \
        '--X*' \
        '--Y*' \
        "${FILE_PATH}" && exit 0
}

handle_hex() {
    # shellcheck disable=SC2154
    if [[ "$lf_user_view" = "hex" ]]; then
        xxd -R always "${FILE_PATH}" && exit 0
    fi
}

handle_metadata() {
    # shellcheck disable=SC2154
    if [[ "$lf_user_view" = "metadata" ]]; then
        invoke_exiftool
    fi
}

handle_extension_full() {
    case "${FILE_EXTENSION_FULL_LOWER}" in

    7z | Z | a | ace | alz | arc | arj | bz | bz2 | cab | cpio | deb | gz | \
        jar | lha | lrz | lz | lzh | lzma | lzo | rar | rpm | rz | t7z | tZ | \
        tar | tar.7z | tar.Z | tar.bz | tar.bz2 | tar.gz | tar.lz | tar.lzo | \
        tar.xz | tbz | tbz2 | tgz | tlz | txz | tzo | war | xz | zip)
        atool --list -- "${FILE_PATH}" && exit 0
        bsdtar --list --file "${FILE_PATH}" && exit 0
        exit 1
        ;;

    md | mkd | mkd.txt)
        "${BAT[@]}" --line-range=:"${HEIGHT}" --language markdown "${FILE_PATH}" && exit 0
        ;;

    *) ;;
    esac
}

handle_extension() {
    case "${FILE_EXTENSION_LOWER}" in

    pdf)
        ## Preview as image
        [[ ! -f $THUMBNAIL ]] && gs -o "${THUMBNAIL}" -sDEVICE=png16m -r200 -dLastPage=1 "${FILE_PATH}" >/dev/null
        [[ -f $THUMBNAIL ]] && display_image "$THUMBNAIL"

        ## Preview as text conversion
        pdftotext -l 10 -nopgbrk -q -- "${FILE_PATH}" - | fmt -w "${WIDTH}" && exit 0
        mutool draw -F txt -i -- "${FILE_PATH}" 1-10 | fmt -w "${WIDTH}" && exit 0
        invoke_exiftool
        exit 1
        ;;

    drawio)
        [[ ! -f $THUMBNAIL ]] && ${DRAWIO} -x "${FILE_PATH}" -o "${THUMBNAIL}" --format png --width "${DEFAULT_IMAGE_WIDTH%x*}"
        [[ -f $THUMBNAIL ]] && display_image "$THUMBNAIL"
        ;;

    svg)
        display_image "${FILE_PATH}"
        ;;

    *) ;;
    esac
}

handle_textual() {
    if isutf8 "${FILE_PATH}" >/dev/null; then
        "${BAT[@]}" --line-range=:"${HEIGHT}" "${FILE_PATH}" && exit 0
        head -"${HEIGHT}" "${FILE_PATH}" && exit 0
    fi
}

handle_mime() {
    MIMETYPE="$(file --dereference --brief --mime-type -- "${FILE_PATH}")"

    case "${MIMETYPE}" in

    application/vnd.sqlite3)
        sqlite3 "${FILE_PATH}" ".schema" | "${BAT[@]}" --language sql && exit 0
        ;;

    image/*)
        display_image "${FILE_PATH}"
        ;;

    video/*)
        [[ ! -f $THUMBNAIL ]] && ffmpegthumbnailer -i "${FILE_PATH}" -o "${THUMBNAIL}" -s 0 -m
        [[ -f $THUMBNAIL ]] && display_image "$THUMBNAIL"
        ;;

    application/vnd.openxmlformats-officedocument.wordprocessingml.document)
        pandoc -i "${FILE_PATH}" --to=markdown && exit 0
        ;;

    *) ;;
    esac

    case "${MIMETYPE}" in

    image/* | video/* | audio/* | application/vnd.openxmlformats-officedocument*)
        invoke_exiftool
        exit 1
        ;;

    *) ;;
    esac
}

handle_filetype() {
    FILETYPE="$(file --dereference --brief -- "${FILE_PATH}")"

    case "${FILETYPE}" in

    "MacOS Alias file")
        # shellcheck disable=SC2312
        $REALPATH -s --relative-to="$FILE_PATHONLY" "$(getTrueName "${FILE_PATH}")" && exit 0
        ;;

    *) ;;
    esac
}

handle_fallback() {
    file --dereference --uncompress --no-sandbox --brief -- "${FILE_PATH}" | fmt -w "${WIDTH}" && exit 0
    exit 1
}

handle_hex
handle_metadata
handle_extension_full
handle_extension
handle_textual
handle_mime
handle_filetype
handle_fallback
