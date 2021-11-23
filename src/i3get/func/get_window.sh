#!/bin/bash

get_window() {

  local json
  json=${_o[json]:-$(i3-msg -t get_tree)}

  awk -f <(
    echo "
    BEGIN {
      ${_o[instance]:+
        arg_target=\"instance\"
        arg_search[arg_target]=\"${_o[instance]}\"
      }
      ${_o[class]:+
        arg_target=\"class\"
        arg_search[arg_target]=\"${_o[class]}\"
      }
      ${_o[conid]:+
        arg_target=\"id\"
        arg_search[arg_target]=\"${_o[conid]}\"
      }
      ${_o[id]:+
        arg_target=\"window\"
        arg_search[arg_target]=\"${_o[id]}\"
      }
      ${_o[mark]:+
        arg_target=\"marks\"
        arg_search[arg_target]=\"${_o[mark]}\"
      }
      ${_o[title]:+
        arg_target=\"name\"
        arg_search[arg_target]=\"${_o[title]}\"
      }
      ${_o[titleformat]:+
        arg_target=\"title_format\"
        arg_search[arg_target]=\"${_o[titleformat]}\"
      }
      ${_o[role]:+
        arg_target=\"window_role\"
        arg_search[arg_target]=\"${_o[role]}\"
      }
      ${_o[type]:+
        arg_target=\"window_type\"
        arg_search[arg_target]=\"${_o[type]}\"
      }
      arg_print=\"${_o[print]:-n}\"
    }"
    _awklib
  ) FS=: RS=, <<< "$json"
}
