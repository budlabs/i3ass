#!/usr/bin/env bash

setincludes(){
  local entry_expand entry_width listview_layout 
  local window_content horibox_content listview_lines

  [[ -n ${_o[prompt]} ]] || _o[include]=${_o[include]/[p]/}

  if [[ -f $_tmp_list_file ]]; then

    [[ -n ${_o[orientation]:-} ]] && {
      __orientation=${_o[orientation]}
      [[ $__orientation = vertical ]] && [[ -z ${_o[height]} ]] \
        && __height=0
    }
    listview_layout="$__orientation"
    listview_lines=$(wc -l < "$_tmp_list_file")


  else
    _o[include]=${_o[include]/[l]/}
    entry_expand=true
    entry_width=0
  fi

  [[ ${_o[include]} =~ [p] ]] && inc+=(prompt)
  [[ ${_o[include]} =~ [e] ]] && inc+=(entry)

  if [[ $__orientation = vertical ]]; then
   
    _o[include]=${inc[*]}
    window_content="[ mainbox ]"
    inputbar_content="[${_o[include]//' '/','}]"
  else
    # limit number of lines in horizontal menu, 
    # it gets slow otherwise...
    ((listview_lines > 500)) && listview_lines=500
    [[ ${_o[include]} =~ [l] ]] && inc+=(listview)
    _o[include]=${inc[*]}
    horibox_content="[${_o[include]//' '/','}]"
    window_content="[ horibox ]"
  fi


  # TODO: why this test for negative zero???
  if [[ $__layout = mouse ]] || { [[ $__ypos -lt 0 || $__ypos = -0 ]] && ((_o[anchor]<7)) ;}; then

    ((_o[no-auto-position])) || adjustposition "$__ypos" &
    
    # move window offscreen if:
    { 
      # negative ypos or xpos is outside of screen
      { [[ $__ypos -lt 0 || $__ypos = -0 ]] && ((_o[anchor]<7)) ;} || \
      ((__xpos+${__width%px}>i3list[WAW]))

    } && __ypos=9999999

  fi 


  __themelayout="
  * {
    window-anchor:    ${__anchor:-north west};
    window-content:   ${window_content:-[horibox,listview]};
    horibox-content:  ${horibox_content:-[prompt, entry]};
    window-width:     ${__width};
    window-height:    ${__height};
    window-x:         ${__xpos}px;
    window-y:         ${__ypos}px;
    listview-layout:  ${listview_layout:-horizontal};
    listview-lines:   ${listview_lines:-50};
    entry-expand:     ${entry_expand:-false};
    entry-width:      ${entry_width:-10em};
    inputbar-content: ${inputbar_content:-[prompt,entry]};
  }
  "
}
