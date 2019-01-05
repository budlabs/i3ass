#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

main(){
  ___printversion
  echo
  whosinstalled $(asslist)
  echo
  echo 'dependencies:'
  checkdeps $(deplist)
}

___source="$(readlink -f "${BASH_SOURCE[0]}")"  #bashbud
___dir="${___source%/*}"                        #bashbud
source "$___dir/init.sh"                        #bashbud
main "$@"                                       #bashbud
