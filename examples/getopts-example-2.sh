#!/bin/bash
# https://en.wikipedia.org/wiki/Getopts

# print arguments passed to script
echo "script arguments=${@}"

# We use "${@}" instead of "${*}" to preserve argument-boundary information
# --options
# a: == expected argument; allow long options starting with single -
# l:: == optional argument; the long options to be recognized
# v == no argument; verbosity
ARGS=$(getopt --options 'a:hl::v' --longoptions 'article:,help,lang::,language::,verbose' -- "${@}") || exit
echo "ARGS=${ARGS}"

eval "set -- ${ARGS}"

function usage() {
    cat << EOF
    usage: $(basename "$0")

    -a, --article
    -h, --help
    -l,--lang,--language
    -v
EOF
}

VERBOSE=''
ARTICLE=''
LANG=''
while true; do
    echo "while true, do=${*}"
    echo "what are the ARGS=${ARGS}"
    echo "what are the @=${@}"
    echo "case=${1}"
    case "${1}" in
        (-h | --help)
            usage ""
            echo "shift 2"
            shift 2
            exit 0
        ;;
        (-v | --verbose)
            ((VERBOSE++))
            echo "shift 1"
            shift 1
        ;;
        (-a | --article)
            ARTICLE="${2}"
            echo "shift 2"
            shift 2
        ;;
        (-l | --lang | --language)
            # handle optional: getopt normalizes it into an empty string
            if [ -n "${2}" ] ; then
                LANG="${2}"
            fi
            echo "shift 2"
            shift 2
        ;;
        (--)
            echo "shift 1"
            shift 1
            break
        ;;
        (*)
            exit 1    # error
        ;;
    esac
    echo "###"
done

echo "VERBOSE=${VERBOSE}"
echo "ARTICLE=${ARTICLE}"
echo "LANG=${LANG}"

remaining_args=("${@}")
echo "remaining arguments=${remaining_args[*]}"
