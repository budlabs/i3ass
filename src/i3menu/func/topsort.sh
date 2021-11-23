#!/bin/bash

topsort() {
# this function generates a awk script

# dynamically created BEGIN block for awk
# with array top_arg[] where each key is a line
# from the ARG passed to --top
echo "BEGIN{"
while read -r top_line ; do
  echo "top_arg[\"$top_line\"]=1"
done <<< "${_o[top]}"
echo "}"

cat << 'END_OF_AWK_MAIN_LOOP'
{
  if ($0 in top_arg) {first[$0]=1}
  else {rest[NR]=$0}
}

END {
  for (k in first) { print k }
  for (i=1;i<=NR;i++) {
    if (i in rest)
      print rest[i]
  }
}
END_OF_AWK_MAIN_LOOP
}
