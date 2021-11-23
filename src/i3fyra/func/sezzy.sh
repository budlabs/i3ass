#!/bin/bash

sezzy() {
  local criterion=$1 args
  shift
  args=$*
  (( _o[verbose] )) && ERM "r [$criterion] $args"
  (( _o[dryrun]  )) || new_size["$criterion"]=$args
}
