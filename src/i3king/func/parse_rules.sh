#!/bin/bash

parse_rules() {

  declare -A vars
  local re_set re_group re_rule rule_type
  local last_line_type

  re_set='^\s*set\s+[$](\S+)\s+(.+)$'
  re_group='(\s*([^=[:space:]]+)=([^=]+\S)\s*)$'
  re_rule='^(GLOBAL|DEFAULT|ON_CLOSE|TITLE)?((\s+)?(.+)\s*)?$'

  declare -i counter_criteria counter_commands
  declare -f dummy_command

  dummy_command() {

    # this function is triggered when a rule is
    # declared without a command. So we add the command
    # 'nop' (no operation).

    local  msg='nop SYNTAX ERROR in i3king file'
   
    while ((counter_commands < counter_criteria)); do
      commands[counter_commands++]=$msg
    done
  }
  
  while read -r  ; do

    line="${prevline:+$prevline }$REPLY"

    [[ $line =~ ^[[:space:]]*$ || $line =~ ^[[:space:]]*# ]] \
      && continue

    if [[ $line =~ \\$ ]]; then
      prevline=${line%\\}
      continue
    else
      unset prevline
    fi
    
    if [[ $line =~ $re_set ]]; then
      vars["${BASH_REMATCH[1]}"]=${BASH_REMATCH[2]}

    # line is indented, parse command
    elif [[ $line =~ ^[[:space:]]+(.+)[[:space:]]*$ ]]; then

      cmd=${BASH_REMATCH[1]}
      for k in "${!vars[@]}"; do
        cmd=${cmd//\$$k/${vars[$k]}}
      done

      # use command id instead of storing cmd string

      while ((counter_commands < counter_criteria)); do
        commands[counter_commands++]=$cmd
      done

      last_line_type="command"

    elif [[ $line =~ $re_rule ]]; then

      [[ $last_line_type = rule ]] && dummy_command "$line"

      # re_rules=^(GLOBAL|DEFAULT|ON_CLOSE|TITLE)?((\s+)?(.+)\s*)?$
      rule_type=${BASH_REMATCH[1]:-NORMAL}

      [[ $rule_type = ON_CLOSE && ! ${BASH_REMATCH[4]} ]] \
        && continue # criteria mandatory

      # group by comma
      mapfile -t ignore_combined <<< "${BASH_REMATCH[4]//,/$'\n'}"

      for crit in "${ignore_combined[@]}"; do

        [[ $crit =~ = || $rule_type =~ DEFAULT|GLOBAL ]] || {
          ERR "'$line'" $'\n' \
              "Expected criteria, got ('$crit') A missplaced command?"

          continue
        }

        # if we don't have  a criteria it is
        # a line with a single GLOBAL/DEFAULT
        # we set the (blacklist) rule to nonsense (-)
        # to make sure it never matches
        if [[ $crit ]]; then
          wc="${_fs}[^${_fs}]*$_fs" # wildcard :.*:
          rule="class${wc}instance${wc}title${wc}window_type${wc}window_role${wc}"
        else
          # this rule should never match
          rule="-$_fs$_fs$_fs"
        fi

        while [[ $crit =~ $re_group ]]; do

          # re_group='(\s*([^=[:space:]]+)=([^=]+\S)\s*)$'

          crit=${crit:0:$((${#BASH_REMATCH[1]}*-1))}
          key=${BASH_REMATCH[2]} 
          val=${BASH_REMATCH[3]//\\s/[[:space:]]}
          val=${val// /[[:space:]]}

          # remove double quotes
          val=${val#\"} val=${val%\"}

          # ^ and $
          if [[ $val =~ ^\^(.+)\$$ ]]; then
            val="(${BASH_REMATCH[1]})"
          elif [[ $val =~ ^\^(.+) ]]; then
            val="(${BASH_REMATCH[1]})[^${_fs}]*"
          elif [[ $val =~ ^(.+)\$$ ]]; then
            val="[^${_fs}]*(${BASH_REMATCH[1]})"
          fi

          rule=${rule/$key${_fs}\[^${_fs}]\*${_fs}/$key${_fs}$val${_fs}}
        done

        [[ -a $_file_log && -z ${_o[print-commands]} ]] && {
          rule_out=${rule//$_fs/:}
          rule_out=${rule_out//\[^:]/.}
          echo "$rule_out" 
        } >> "$_file_log"

        case "$rule_type" in
          DEFAULT  ) default_rules[counter_criteria++]=$rule ;;
          GLOBAL   ) global_rules[counter_criteria++]=$rule  ;;
          ON_CLOSE ) close_rules[counter_criteria++]=$rule   ;;
          TITLE    ) title_rules[counter_criteria++]=$rule   ;;
          *        ) rules[counter_criteria++]=$rule         ;;
        esac

      done

      last_line_type=rule
    fi

  done < "$1"

  [[ $last_line_type = rule ]] && dummy_command
}
