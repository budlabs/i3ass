#!/bin/bash

_dir=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
name=${_dir##*/}
monolith="_${name}.sh"

monolith="_${_dir##*/}.sh"
cmd_base+=("$_dir/$monolith" --array "$(< "$_dir/tests/array")" --dryrun --verbose)
cmd1+=(--move up)

loops=20

# source_files are all manually written code
# used to get correct linecount (LOC)
source_files=("$_dir/$name")

for f in "$_dir/func"/* ; do
  [[ ${f##*/} =~ ^[a-z] ]] && source_files+=("$f")
done

[[ -d "$_dir/awklib" ]] && source_files+=("$_dir/awklib"/*)

while read -r ; do
  clear
  make
  shellcheck "$_dir/$monolith" && {

    "${cmd_base[@]}" "${cmd1[@]}"
    "${cmd_base[@]}" "${cmd1[@]}" 2> "$_dir/tests/results"
    
    diff "$_dir/tests/results" "$_dir/tests/ref1"

    echo $'\n'"loop: $monolith ${cmd1[*]} ; x$loops:"
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
