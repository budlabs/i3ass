#!/bin/bash #bashbud

[[ $BASHBUD_VERBOSE -eq 1 || $* =~ --verbose ]] && ___t=1
[[ $* =~ --dryrun ]]  && ___t=0

((___t)) && {
  ___t=$(( 10#${EPOCHREALTIME//[!0-9]} ))

  # don't include options after "--verbose" in debug output
  # example: i3fyra --move C --verbose --conid 94881549553328
  # will result in: i3fyra --move C
  for ___arg ; do
    [[ $___arg = --verbose ]] && break

    # replace --json argument with ...
    [[ $___replace_next ]] && {
      ___debug_args+=(...)
      unset -v ___replace_next
      continue
    }

    [[ $___arg = --json ]] && ___replace_next=1
    ___debug_args+=("$___arg")
  done


  printf -v ___cmd "%s " "${0##*/}" "${___debug_args[@]}"
  unset -v ___arg '___debug_args[@]'
  >&2 echo ">>> $___cmd"
}
