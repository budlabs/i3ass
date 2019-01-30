#!/usr/bin/env bash

___printversion(){
  
cat << 'EOB' >&2
i3ass - version: 2019.01.30.2
updated: 2019-01-30 by budRich
EOB
}



___printhelp(){
  
cat << 'EOB' >&2
i3ass - i3 assistance scripts


OPTIONS
-------
EOB
}


for ___f in "${___dir}/lib"/*; do
  source "$___f"
done


[[ ${__lastarg:="${!#:-}"} =~ ^--$|${0}$ ]] \
  && __lastarg="" \
  || true



