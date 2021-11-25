#!/bin/bash

trap 'tput clear' SIGWINCH

_source=$(readlink -f "${BASH_SOURCE[0]}")
_dir=${_source%/*}

name="_${_dir##*/}.sh"

loops=20

source_files=("$_dir/${_dir##*/}")

for f in "$_dir/func"/* ; do
  [[ ${f##*/} =~ ^[a-z] ]] && source_files+=("$f")
done

[[ -d "$_dir/awklib" ]] && source_files+=("$_dir/awklib"/*)

cmd_base+=("$_dir/$name" --json "$(< "$_dir/tests/tree.json")" --dryrun --verbose)
cmd1+=(--move next)

while read -r ; do
  clear
  make
  shellcheck "$_dir/$name" && {

    "${cmd_base[@]}" "${cmd1[@]}"
    "${cmd_base[@]}" "${cmd1[@]}" 2> "$_dir/tests/results"
    
    diff "$_dir/tests/results" "$_dir/tests/ref1"

    echo $'\n'"loop: $name ${cmd1[*]} ; x$loops:"
    time(
      while ((++i<loops));do 
        "${cmd_base[@]}" "${cmd1[@]}"
      done > /dev/null 2>&1
    )

    echo -n $'\n'"LOC: "
    cat "${source_files[@]}" | grep -E '^\s*[^#].+$' | wc -l
  }
done < <(
  inotifywait \
    --event close_write --monitor --recursive \
    --exclude '^[.]/((func/)?_.*)|([.]cache.+)|(tests.+)|(.+[.]1)' .
)
