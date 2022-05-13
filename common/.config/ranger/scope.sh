#!/usr/bin/env bash
#
# help on structure: /usr/share/doc/ranger/config/scope.sh or
# https://github.com/ranger/ranger/blob/master/ranger/data/scope.sh.

set -o noclobber
set -o noglob
set -o nounset
set -o pipefail

IFS=$'\n'

FILE_PATH="${1}"
PV_WIDTH="${2:-80}"
# shellcheck disable=SC2034
PV_HEIGHT="${3:-30}"
# shellcheck disable=SC2034
IMAGE_CACHE_PATH="${4:-/tmp}"
# shellcheck disable=SC2034
PV_IMAGE_ENABLED="${5:-False}"

FILE_EXTENSION_LOWER="$(printf "%s" "${FILE_PATH##*.}" | tr '[:upper:]' '[:lower:]')"
FILE_EXTENSION_FULL_LOWER=$(printf "%s" "${FILE_PATH#*.}" | tr '[:upper:]' '[:lower:]')

HIGHLIGHT=("highlight" "--out-format=ansi")

HIGHLIGHT_SUPPORTS_SYNTAX_BY_NAME=false
highlight --out-format=truecolor --syntax-by-name=c </dev/null >/dev/null 2>/dev/null && HIGHLIGHT_SUPPORTS_SYNTAX_BY_NAME=true

macos_check() {
    if [[ ${OSTYPE} == darwin* ]]; then
        echo "Cannot display on MacOS, see https://github.com/ranger/ranger/issues/1787."
        exit 0
    fi
}

case "${FILE_EXTENSION_FULL_LOWER}" in
"md" | "mkd" | "mkd.txt")
    "${HIGHLIGHT[@]}" --syntax=markdown "${FILE_PATH}" && exit 5
    ;;
"webloc")
    "${HIGHLIGHT[@]}" --syntax=xml "${FILE_PATH}" && exit 5
    ;;
"tar.xz")
    tar tjvf "${FILE_PATH}" && exit 5
    exit 1
    ;;
"htm" | "html" | "xhtml")
    w3m -dump "${FILE_PATH}" && exit 5
    lynx -dump -- "${FILE_PATH}" && exit 5
    elinks -dump "${FILE_PATH}" && exit 5
    pandoc -s -t markdown -- "${FILE_PATH}" && exit 5
    ;;
"tf")
    head -"${PV_HEIGHT}" "${FILE_PATH}" | "${HIGHLIGHT[@]}" --syntax=terraform 2>/dev/null && exit 5
    ;;
*) ;;
esac

if isutf8 "${FILE_PATH}" >/dev/null; then
    # Only highlight the relevant lines to speed up highlighting, make this more
    # robust on MacOS.
    if ${HIGHLIGHT_SUPPORTS_SYNTAX_BY_NAME}; then
        head -"${PV_HEIGHT}" "${FILE_PATH}" | "${HIGHLIGHT[@]}" --syntax-by-name="${FILE_PATH}" 2>/dev/null && exit 5
    fi
    head -"${PV_HEIGHT}" "${FILE_PATH}" | "${HIGHLIGHT[@]}" 2>/dev/null && exit 5
    head -"${PV_HEIGHT}" "${FILE_PATH}" && exit 5
fi

case "${FILE_EXTENSION_LOWER}" in
"Z" | \
    "a" | \
    "ace" | \
    "alz" | \
    "arc" | \
    "arj" | \
    "bz" | \
    "bz2" | \
    "cab" | \
    "cpio" | \
    "deb" | \
    "gz" | \
    "jar" | \
    "lha" | \
    "lz" | \
    "lzh" | \
    "lzma" | \
    "lzo" | \
    "rar" | \
    "rpm" | \
    "rz" | \
    "t7z" | \
    "tZ" | \
    "tar" | \
    "tbz" | \
    "tbz2" | \
    "tgz" | \
    "tlz" | \
    "txz" | \
    "tzo" | \
    "war" | \
    "xpi" | \
    "xz" | \
    "zds" | \
    "zip" | \
    "7z")

    macos_check
    atool --list -- "${FILE_PATH}" && exit 5
    bsdtar --list --file "${FILE_PATH}" && exit 5
    exit 1
    ;;
"pdf")
    pdftotext -l 10 -nopgbrk -q -- "${FILE_PATH}" - | fmt -w "${PV_WIDTH}" && exit 5
    mutool draw -F txt -i -- "${FILE_PATH}" 1-10 | fmt -w "${PV_WIDTH}" && exit 5
    exiftool "${FILE_PATH}" && exit 5
    exit 1
    ;;
"docx")
    docx2txt.pl "${FILE_PATH}" - | fmt -s -w "${PV_WIDTH}" && exit 4
    exit 1
    ;;
"mp3")
    id3v2 -l "${FILE_PATH}" && exit 5
    ;;
*) ;;
esac

macos_check

mimetype=$(file --mime-type -Lb "${FILE_PATH}")

case "${mimetype}" in
image/*)
    # shellcheck disable=SC2154
    if [[ -z "${TMUX}" ]]; then
        exit 7
    else
        exiftool "${FILE_PATH}" && exit 5
    fi
    ;;
*);;
esac

case "${mimetype}" in
video/* | audio/* | application/vnd.openxmlformats-officedocument/*)
    exiftool "${FILE_PATH}" && exit 5
    exit 1
    ;;
*) ;;
esac

file --dereference --brief -- "${FILE_PATH}" | fmt -w "${PV_WIDTH}" && exit 5

exit 1
