#!/usr/bin/env bash

set -o noclobber
set -o noglob
set -o nounset
set -o pipefail

IFS=$'\n'

FILE_PATH="${1}"
WIDTH="${2:-80}"
HEIGHT="${3:-30}"
HORIZ_POS="${4}"
VERT_POS="${5}"

FILE_EXTENSION="${FILE_PATH##*.}"
FILE_EXTENSION_LOWER="$(printf "%s" "${FILE_EXTENSION}" | tr '[:upper:]' '[:lower:]')"
FILE_EXTENSION_FULL_LOWER=$(printf "%s" "${FILE_PATH#*.}" | tr '[:upper:]' '[:lower:]')

HIGHLIGHT=("highlight" "--out-format=ansi")

handle_fullname() {
    case $(basename "${FILE_PATH}") in
    "Dockerfile")
        "${HIGHLIGHT[@]}" --syntax=Dockerfile "${FILE_PATH}" && exit 0
        ;;
    "Makefile")
        "${HIGHLIGHT[@]}" --syntax=Makefile "${FILE_PATH}" && exit 0
        ;;
    *) ;;
    esac
}

handle_extension_full() {
    case "${FILE_EXTENSION_FULL_LOWER}" in
    "md" | "mkd" | "mkd.txt")
        "${HIGHLIGHT[@]}" --syntax=markdown "${FILE_PATH}" && exit 0
        ;;
    "htm" | "html" | "xhtml")
        w3m -dump "${FILE_PATH}" && exit 0
        ;;
    "tf")
        head -"${HEIGHT}" "${FILE_PATH}" | "${HIGHLIGHT[@]}" --syntax=terraform 2>/dev/null && exit 0
        ;;
    "tfstate")
        head -"${HEIGHT}" "${FILE_PATH}" | "${HIGHLIGHT[@]}" --syntax=json 2>/dev/null && exit 0
        ;;
    "webloc")
        "${HIGHLIGHT[@]}" --syntax=xml "${FILE_PATH}" && exit 0
        ;;
    *) ;;
    esac
}

handle_highlight() {
    if isutf8 "${FILE_PATH}" >/dev/null; then
        # Only highlight the relevant lines to speed up highlighting, make this more
        # robust on MacOS.
        if "${HIGHLIGHT[@]}" --syntax-supported --syntax-by-name="${FILE_PATH}" >/dev/null 2>/dev/null; then
            head -"${HEIGHT}" "${FILE_PATH}" | "${HIGHLIGHT[@]}" --syntax-by-name="${FILE_PATH}" 2>/dev/null && exit 0
        fi
        head -"${HEIGHT}" "${FILE_PATH}" | "${HIGHLIGHT[@]}" 2>/dev/null && exit 0
        head -"${HEIGHT}" "${FILE_PATH}" && exit 0
    fi
}

handle_extension() {
    case "${FILE_EXTENSION_LOWER}" in
        ## Archive
        a|ace|alz|arc|arj|bz|bz2|cab|cpio|deb|gz|jar|lha|lz|lzh|lzma|lzo|\
        rpm|rz|t7z|tar|tbz|tbz2|tgz|tlz|txz|tZ|tzo|war|xpi|xz|Z|zip)
            atool --list -- "${FILE_PATH}" && exit 0
            bsdtar --list --file "${FILE_PATH}" && exit 0
            exit 1;;
        rar)
            ## Avoid password prompt by providing empty password
            unrar lt -p- -- "${FILE_PATH}" && exit 0
            exit 1;;
        7z)
            ## Avoid password prompt by providing empty password
            7z l -p -- "${FILE_PATH}" && exit 0
            exit 1;;

        pdf)
            ## Preview as text conversion
            pdftotext -l 10 -nopgbrk -q -- "${FILE_PATH}" - | \
              fmt -w "${WIDTH}" && exit 0
            mutool draw -F txt -i -- "${FILE_PATH}" 1-10 | \
              fmt -w "${WIDTH}" && exit 0
            exiftool "${FILE_PATH}" && exit 0
            exit 1;;
        docx)
            docx2txt.pl "${FILE_PATH}" - | fmt -s -w "${WIDTH}" && exit 0
            exit 1;;

        mp3)
            id3v2 -l "${FILE_PATH}" && exit 0
            ;;
        *)
            ;;
    esac
}

handle_mime() {
    local mimetype="${1}"
    case "${mimetype}" in
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
        exit 1;;
    *) ;;
    esac
}

handle_fallback() {
    file --dereference --uncompress --brief -- "${FILE_PATH}" | fmt -w "${WIDTH}" && exit 0
    exit 1
}

MIMETYPE="$(file --dereference --brief --mime-type -- "${FILE_PATH}")"
handle_fullname
handle_extension_full
handle_extension
handle_highlight
handle_mime "${MIMETYPE}"
handle_fallback
