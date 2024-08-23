#!/bin/bash
ARGS=$(getopt --options 'b:h' --longoptions 'bool:,help' -- "${@}") || exit
eval "set -- ${ARGS}"
BOOL=''
while true; do
  case "${1}" in
    (-h | --help)
      echo "help message"
      shift 2
      exit 0
    ;;
    (-b | --bool)
      BOOL=${2}
      shift 2
    ;;
    (--)
      shift 1
      break
    ;;
    (*)
      exit 1  # error
    ;;
  esac
done

if [[ "${BOOL}" == "true" ]]; then
  echo "bool = true"
else
  echo "bool = false"
fi
