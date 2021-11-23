#!/bin/bash

_source=$(readlink -f "${BASH_SOURCE[0]}")
_dir=${_source%/*}

while read -r ; do
  clear
  bashbud --bump "$_dir"
  shellcheck "$_dir/program.sh" && {
    "$_dir/program.sh" -p --json "$(< "$_dir/tests/tree.json")"
    time(
      while ((++i<50));do 
        "$_dir/program.sh" -p --json "$(< "$_dir/tests/tree.json")"
      done >/dev/null
    )
  }
done < <(
  inotifywait --event close_write          \
              --recursive --monitor        \
              --exclude 'awklib[.]sh$'     \
              "$_dir"/awklib/*.awk         \
              "$_dir"/lib/*.sh             \
              "$_dir/main.sh"              \
              "$_dir/watch.sh"             \
              "$_dir/manifest.md"
)
