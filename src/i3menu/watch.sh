#!/bin/bash

_source=$(readlink -f "${BASH_SOURCE[0]}")
_dir=${_source%/*}

while read -r ; do
  clear
  make check
  # && {
  #   "$_dir/program.sh" -p --json "$(< "$_dir/tests/tree.json")"
  #   time(
  #     while ((++i<50));do 
  #       "$_dir/program.sh" -p --json "$(< "$_dir/tests/tree.json")"
  #     done >/dev/null
  #   )
  # }
done < <(
  inotifywait --event close_write          \
              --recursive --monitor        \
              --exclude 'createconf[.]sh$'     \
              "$_dir"/func/*.sh             \
              "$_dir"/docs/*.md             \
              "$_dir"/docs/options/*             \
              "$_dir/i3menu"              \
              "$_dir/watch.sh"             
)
