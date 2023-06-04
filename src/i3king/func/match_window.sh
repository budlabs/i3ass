#!/bin/bash

match_window() {

  local cid=$1 class=$2 instance=$3 title=$4 
  local type=$5 role=$6 wid=$7 change=$8

  local last_cmd cmd rule
  local title_regex title_options new_title

  local identifier=""

  identifier+="class$_fs$2$_fs"
  identifier+="instance$_fs$3$_fs"
  identifier+="title$_fs$4$_fs"
  identifier+="window_type$_fs$type$_fs"
  identifier+="window_role$_fs$role$_fs"

  declare -a matches default_execute execute

  [[ $cid =~ ^[0-9]{5,}$ ]] \
    || ERX "match_window(): $cid is not a valid containerID"

  case "$change" in
  close )
    for rule in "${!close_rules[@]}"; do
      [[ $identifier =~ ${close_rules[$rule]} ]] || continue
      cmd=${commands[$rule]}
      [[ $cmd = "$last_cmd" ]] && continue
      last_cmd=$cmd

      execute+=("$cmd")
      matches+=("ON_CLOSE: ${close_rules[$rule]}"$'\n'$'\t'"$cmd")
    done
    ;;
  new )
    # test default rules first
    for rule in "${!default_rules[@]}"; do

      cmd=${commands[$rule]}

      [[ $identifier =~ ${default_rules[$rule]} ]] && {

        [[ $cmd = "$last_cmd" ]] && {
          unset 'default_execute[-1]'
          unset 'matches[-1]'
        }
        last_cmd=$cmd
        continue
      }

      [[ $cmd = "$last_cmd" ]] && continue
      last_cmd=$cmd

      default_execute+=("$cmd")
      matches+=("DEFAULT: -"$'\n'$'\t'"$cmd")

    done

    unset last_cmd

    # then global rules
    for rule in "${!global_rules[@]}"; do

      cmd=${commands[$rule]}

      [[ $identifier =~ ${global_rules[$rule]} ]] && {

        [[ $cmd = "${execute[-1]}" ]] && {
          unset 'execute[-1]'
          unset 'matches[-1]'
        }
        last_cmd=$cmd
        continue
      }

      [[ $cmd = "$last_cmd" ]] && continue
      last_cmd=$cmd

      execute+=("$cmd")
      matches+=("GLOBAL: -"$'\n'$'\t'"$cmd")
    done

    unset last_cmd

    for rule in "${!rules[@]}"; do
      [[ $identifier =~ ${rules[$rule]} ]] || continue
      cmd=${commands[$rule]}
      [[ $cmd = "$last_cmd" ]] && continue
      last_cmd=$cmd

      rule_out=${rules[$rule]//$_fs/:}
      rule_out=${rule_out//\[^:]/.}

      execute+=("$cmd")
      matches+=("NORMAL: $rule_out"$'\n'$'\t'"$cmd")
    done
    ;& # FALLTHRU !!!!
  
  title) #  apply both to new windows and titlechange
    for rule in "${!title_rules[@]}"; do
      [[ $identifier =~ ${title_rules[$rule]} ]] || continue
      cmd=${commands[$rule]}
      cmd=${cmd//\\\//@@SLASH@@}
      [[ $cmd =~ ^([^/]+)?/([^/]+)/[[:space:]]+(.+)$ ]] && {
        title_regex=${BASH_REMATCH[2]//@@SLASH@@//}
        new_title=${BASH_REMATCH[3]}
        title_options=${BASH_REMATCH[1]}

        [[ $title =~ ${title_regex} ]] && {
          for rematch in "${!BASH_REMATCH[@]}"; do
            ((rematch)) || continue
            new_title="${new_title//\$$rematch/${BASH_REMATCH[rematch]}}"
          done
        }

        case "$title_options" in
        "~0" )
          [[ $new_title =~ ("${HOME}"[/]?) ]] && {
            new_title=${new_title//${BASH_REMATCH[1]}/}
            [[ $new_title ]] || new_title="~"
          }
          ;;

        "~1" )
          [[ $new_title =~ ("${HOME}") ]] \
            && new_title=${new_title//${BASH_REMATCH[1]}/'~'}
          ;;
        esac
      }

      execute+=("title_format $new_title")
      matches+=("TITLE: $title")
      matches+=("REGEX: $cmd")
    done
    ;;
  esac

  [[ -a $_file_log && ${#matches[@]} -gt 0 ]] && {
    echo $'\n'"WINDOW: "\
     "${identifier//$_fs/:}"$'\n'
    for k in "${matches[@]}"; do
      echo "$k"
    done
    echo
    echo EXECUTE:
  } >> "$_file_log"

  ((${#execute[@]})) && unset 'default_execute[@]'
  ((${#default_execute[@]})) && execute=("${default_execute[@]}")

  ((${#execute[@]})) && {
    
    for k in "${execute[@]}"; do

      cmd=$k
      cmd=${cmd//\$INSTANCE/$instance}
      cmd=${cmd//\$ROLE/$role}
      cmd=${cmd//\$TYPE/$type}
      cmd=${cmd//\$CLASS/$class}
      cmd=${cmd//\$CONID/$cid}
      cmd=${cmd//\$WINID/$wid}
      cmd=${cmd//\$TITLE/$title}

      [[ -a $_file_log ]] && echo $'\t'"$cmd" >> "$_file_log"

      if [[ $change = close ]]; then
        # without prefixing command with ; 
        # the command is not executed everytime.
        # not sure why, but it works like this
        prefix=";"
      else
        # cant prefix with conid when we close
        # since the window doesn't exist
        prefix="[con_id=$cid]"
      fi

      ((_o[print-commands] || _o[dryrun])) \
        || >&2 i3-msg "${prefix:-} $cmd"

      ((_o[print-commands])) \
        && echo "${prefix:-} $cmd"
      
    done
  }
}
