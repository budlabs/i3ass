#!/bin/bash

_source=$(readlink -f "${BASH_SOURCE[0]}")
_dir=${_source%/*}

while read -r ; do
  clear
  bashbud --bump "$_dir"
  shellcheck "$_dir/program.sh"
done < <(
  inotifywait --event close_write          \
              --recursive --monitor        \
              --exclude 'awklib[.]sh$'     \
              "$_dir"/lib/*.sh             \
              "$_dir/main.sh"              \
              "$_dir/manifest.md"
)
