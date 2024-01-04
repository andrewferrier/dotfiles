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

FILE_EXTENSION="${FILE_PATH##*.}"
FILE_EXTENSION_LOWER="$(printf "%s" "${FILE_EXTENSION}" | tr '[:upper:]' '[:lower:]')"
FILE_EXTENSION_FULL_LOWER=$(printf "%s" "${FILE_PATH#*.}" | tr '[:upper:]' '[:lower:]')

if (command -v batcat >/dev/null 2>&1); then
    BAT=("batcat" "--color=always")
else
    BAT=("bat" "--color=always")
fi

handle_extension_full() {
    case "${FILE_EXTENSION_FULL_LOWER}" in

    "md" | "mkd" | "mkd.txt")
        "${BAT[@]}" --language markdown "${FILE_PATH}" && exit 0
        ;;

    "htm" | "html" | "xhtml")
        w3m -dump "${FILE_PATH}" && exit 0
        ;;

    *) ;;
    esac
}

handle_textual() {
    if isutf8 "${FILE_PATH}" >/dev/null; then
        "${BAT[@]}" "${FILE_PATH}" && exit 0
        head -"${HEIGHT}" "${FILE_PATH}" && exit 0
    fi
}

handle_extension() {
    case "${FILE_EXTENSION_LOWER}" in

    a | ace | alz | arc | arj | bz | bz2 | cab | cpio | deb | gz | jar | lha | lz | lzh | lzma | lzo | \
        rpm | rz | t7z | tar | tbz | tbz2 | tgz | tlz | txz | tZ | tzo | war | xpi | xz | Z | zip)
        atool --list -- "${FILE_PATH}" && exit 0
        bsdtar --list --file "${FILE_PATH}" && exit 0
        exit 1
        ;;

    rar)
        ## Avoid password prompt by providing empty password
        unrar lt -p- -- "${FILE_PATH}" && exit 0
        exit 1
        ;;

    7z)
        ## Avoid password prompt by providing empty password
        7z l -p -- "${FILE_PATH}" && exit 0
        exit 1
        ;;

    pdf)
        ## Preview as text conversion
        pdftotext -l 10 -nopgbrk -q -- "${FILE_PATH}" - | fmt -w "${WIDTH}" && exit 0
        mutool draw -F txt -i -- "${FILE_PATH}" 1-10 | fmt -w "${WIDTH}" && exit 0
        exiftool "${FILE_PATH}" && exit 0
        exit 1
        ;;

    mp3)
        id3v2 -l "${FILE_PATH}" && exit 0
        ;;

    *) ;;
    esac
}

handle_mime() {
    MIMETYPE="$(file --dereference --brief --mime-type -- "${FILE_PATH}")"

    case "${MIMETYPE}" in

    application/vnd.sqlite3)
        sqlite3 "${FILE_PATH}" ".schema" && exit 0
        ;;

    image/*)
        # Exiting with 1 disables preview cache, forcing cleaning
        kitty +icat --transfer-mode file --stdin no --scale-up --place "${WIDTH}x${HEIGHT}@${HORIZ_POS}x${VERT_POS}" "${FILE_PATH}" </dev/null >/dev/tty && exit 1
        ;;

    application/msword | application/vnd.openxmlformats-officedocument.wordprocessingml.document)
        pandoc -i "${FILE_PATH}" --to=markdown && exit 0
        ;;

    *) ;;
    esac

    case "${MIMETYPE}" in

    image/* | video/* | audio/* | application/vnd.openxmlformats-officedocument/*)
        exiftool -g \
            '--Balance*' \
            '--Blue*' \
            '--Compatible*' \
            '--Create*' \
            '--Current*' \
            '--Directory' \
            '--Exif*' \
            '--ExifTool*' \
            '--Graphics*' \
            '--Green*' \
            '--Handler*' \
            '--Matrix*' \
            '--Media*' \
            '--Minor*' \
            '--Modify*' \
            '--Movie*' \
            '--Op*' \
            '--Poster*' \
            '--Preferred*' \
            '--Preview*' \
            '--Red*' \
            '--Selection*' \
            '--Source*' \
            '--Time*' \
            '--Track*' \
            '--Warning*' \
            '--White*' \
            '--X*' \
            '--Y*' \
            "${FILE_PATH}" && exit 0
        exit 1
        ;;

    *) ;;
    esac
}

handle_fallback() {
    file --dereference --uncompress --brief -- "${FILE_PATH}" | fmt -w "${WIDTH}" && exit 0
    exit 1
}

handle_extension_full
handle_extension
handle_textual
handle_mime
handle_fallback
