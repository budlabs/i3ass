#!/bin/bash

_source=$(readlink -f "${BASH_SOURCE[0]}")
_dir=${_source%/*}

while read -r ; do
  make -C "$_dir"
  shellcheck "$_dir/monolith.sh" && {
    time(
      while ((++i<100));do 
        "$_dir/monolith.sh" -i typiskt --json "$(< $_dir/tests/tree.json)"
      done >/dev/null
    )
  }
done < <(
  inotifywait --event close_write          \
              --recursive --monitor        \
              --exclude 'func/_awklib[.]sh$'     \
              "$_dir"/awklib/*.awk               \
              "$_dir/i3list"               \
              "$_dir/options"
)
