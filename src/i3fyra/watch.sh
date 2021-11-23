#!/bin/bash

_source=$(readlink -f "${BASH_SOURCE[0]}")
_dir=${_source%/*}
ta=$(< "$_dir/tests/array")

trap 'tput clear' SIGWINCH

cmd1=("$_dir/program.sh" --move Up --dryrun --array "$ta")
# cmd2=("$_dir/program.sh" --move up --array "$ta" --dryrun)

while read -r ; do
  clear
  bashbud --bump "$_dir"
  shellcheck "$_dir/program.sh" && {
    # "${cmd1[@]}" --verbose 2>&1 >/dev/null | head -n -3 > "$_dir/tests/results"
    # diff "$_dir/tests/results" "$_dir/tests/ref1"
    time(
      while ((++i<10));do 
        "${cmd1[@]}"
      done > /dev/null 2>&1
    )
    echo -n $'\n'LOC: 
    cat "$_dir/main.sh" "$_dir/lib/"* | grep -E '^\s*[^#].+$' | wc -l
  }
done < <(
  inotifywait --event close_write          \
              --recursive --monitor        \
              --exclude 'awklib[.]sh$'     \
              "$_dir"/lib/*.sh             \
              "$_dir/main.sh"              \
              "$_dir/watch.sh"             \
              "$_dir/manifest.md"
)
