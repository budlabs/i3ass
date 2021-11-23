#!/bin/bash

setfallback(){

 _o[fallback]=""

 declare -a opts
 # using eval here to silence shellcheck
 # $* (_o[fallback]) can look like this: 
 # _o[fallback]='--layout D --fallback "--layout A"'
 eval "opts=($*)"

 eval set -- "$(getopt --name "i3menu" \
   --options "a:i:t:x:y:w:o:p:f:" \
   --longoptions "theme:,layout:,include:,top:,xpos:,xoffset:,ypos:,yoffset:,width:,options:,prompt:,filter:,show:,modi:,target:,orientation:,anchor:,height:,fallback:" \
   -- "${opts[@]}"
 )"

 while true; do
   case "$1" in
     --theme      ) _o[theme]="${2:-}" ; shift ;;
     --layout     | -a ) _o[layout]="${2:-}" ; shift ;;
     --include    | -i ) _o[include]="${2:-}" ; shift ;;
     --top        | -t ) _o[top]="${2:-}" ; shift ;;
     --xpos       | -x ) _o[xpos]="${2:-}" ; shift ;;
     --xoffset    ) _o[xoffset]="${2:-}" ; shift ;;
     --ypos       | -y ) _o[ypos]="${2:-}" ; shift ;;
     --yoffset    ) _o[yoffset]="${2:-}" ; shift ;;
     --width      | -w ) _o[width]="${2:-}" ; shift ;;
     --options    | -o ) _o[options]="${2:-}" ; shift ;;
     --prompt     | -p ) _o[prompt]="${2:-}" ; shift ;;
     --filter     | -f ) _o[filter]="${2:-}" ; shift ;;
     --show       ) _o[show]="${2:-}" ; shift ;;
     --modi       ) _o[modi]="${2:-}" ; shift ;;
     --target     ) _o[target]="${2:-}" ; shift ;;
     --orientation ) _o[orientation]="${2:-}" ; shift ;;
     --anchor     ) _o[anchor]="${2:-}" ; shift ;;
     --height     | -h ) _o[height]="${2:-}" ; shift ;;
     --fallback   ) _o[fallback]="${2:-}" ; shift ;;
     -- ) shift ; break ;;
     *  ) break ;;
   esac
   shift
 done

 [[ ${_o[layout]} =~ A|B|C|D ]] \
   && _o[layout]=$(getvirtualpos "${_o[layout]}")
}
