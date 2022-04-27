#!/bin/bash #bashbud

[[ $BASHBUD_VERBOSE -eq 1 || $* =~ --verbose ]] && ___t=1
[[ $* =~ --dryrun ]]  && ___t=0

((___t)) && {
  ___t=$(( 10#${EPOCHREALTIME//[!0-9]} ))

  for ((___arg=0; ___arg<${#@}+1;___arg++)); do
    [[ ${!___arg} = --verbose ]] && ((___arg--)) && break
  done

  printf -v ___cmd "%s " "${0##*/}" "${@:1:___arg}"
  unset -v ___arg
  >&2 echo ">>> $___cmd"
}
