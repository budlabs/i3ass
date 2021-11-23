#!/bin/bash

_source=$(readlink -f "${BASH_SOURCE[0]}")
_dir=${_source%/*}

loops=20
cmd1a+=("$_dir/_i3flip.sh" --move next)
cmd1b+=(--json "$(< "$_dir/tests/tree.json")" --dryrun)
while read -r ; do
  clear
  make
  shellcheck "$_dir/_i3flip.sh" && {

    "${cmd1a[@]}" "${cmd1b[@]}" --verbose
    "${cmd1a[@]}" "${cmd1b[@]}" --verbose  2> "$_dir/tests/results"
    
    diff "$_dir/tests/results" "$_dir/tests/ref1"

    echo $'\n'"loop ${cmd1a[*]} ; x$loops:"
    time(
      while ((++i<loops));do 
        "${cmd1a[@]}" "${cmd1b[@]}"
      done > /dev/null 2>&1
    )

    echo -n $'\n'"LOC: "
    cat "$_dir/i3flip" "$_dir/func/"* | grep -E '^\s*[^#].+$' | wc -l
  }
done < <(
  inotifywait --event close_write --monitor --recursive \
              --exclude '^[.]/((func/)?_.*)|([.]cache.+)|(tests.+)|(.+[.]1)' .
)
