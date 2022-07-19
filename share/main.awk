# name|title_format field holds the title, it is the value that
# is trickiest to capture since it can contain 
# double quotes, commas (RS) and colon (FS).
# therefor it is handled here separate from the other
# keys, which always are at NF-1.
$1 ~ /"(name|title_format)"/ {
  key=gensub(/"/,"","g",$1)
  
  title=gensub(/^"(name|title_format)":/,"","1",$0)
  title=gensub(/\\"/,"@@_DQ_@@","g",title)

  # this makes sure to capture titles with escaped quotes
  # and commas.
  while (title ~ /[^"]$/ && title != "null") {
    getline
    title = title "," gensub(/\\"/,"@@_DQ_@@","g",$0)
  }
  title=gensub("@@_DQ_@@","\"","g",title)

  ac[cid][key]=title

  if ( key in arg_search && match(title, arg_search[key]) )
    suspect_targets[cid]=1

  # store output container id in separate array
  if ( ac[cid]["type"] ~ /"output"/ && $NF !~ /__i3/)
    outputs[$NF]=cid

  else if (ac[cid]["type"] == "\"workspace\"") {

    if ($NF == "\"" i3fyra_workspace_name "\"")
      i3fyra_workspace_id = cid

    else if ($NF == "\"__i3_scratch\"")
      scratchpad_id = cid
  }
}

$(NF-1) ~ /"(class|current_border_width|floating|focus|focused|fullscreen_mode|id|instance|layout|marks|num|output|sticky|type|urgent|window|window_role|window_type|x)"$/ {
  
  key=gensub(/.*"([^"]+)"$/,"\\1","g",$(NF-1))
    
  switch (key) {

    case "layout":
    case "current_border_width":
    case "fullscreen_mode":
    case "sticky":
    case "urgent":
      ac[cid][key]=$NF
    break

    case "window_type":
    case "window_role":
    case "class":
    case "instance":
    case "type":
      ac[cid][key]=$NF
      if ( key in arg_search && $NF == "\""arg_search[key]"\"" )
        suspect_targets[cid]=1
    break

    case "id":
      # when "nodes": (or "floating_nodes":) and "id":
      # is on the same record.
      #   example -> "nodes":[{"id":94446734049888 
      # it is the start of a branch in the tree.
      # save the last container_id as current_parent_id
      if ($1 ~ /nodes"$/) {
        current_parent_id=cid
      } else if (NR == 1) {
        root_id=$NF
      }

      # cid, "current id" is the last seen container_id
      cid=$NF
      ac[cid][key]=$NF

      # container_order is for viswiz
      container_order[++container_count]=cid

      if ( key in arg_search && $NF == arg_search[key] )
        suspect_targets[cid]=1
    break

    case "x":

      if ($1 ~ /"(deco_)?rect"/) {
        # this will add values to:
        #   ac[cid]["x"] , ["y"] , ["w"] , ["h"]
        #   ac[cid]["deco_x"] , ["deco_y"] , ["deco_w"] , ["deco_h"]
        keyprefix=($1 ~ /"deco_rect"/ ? "deco_" : "")
        while (1) {

          match($0,/"([^"])[^"]*":([0-9]+)([}])?$/,ma)
          ac[cid][keyprefix ma[1]]=ma[2]
          if (ma[3] ~ "}")
            break
          # break before getline, otherwise we will
          # miss the "deco_rect" line..
          getline
        }

        if (keyprefix == "deco_")
          ac[cid]["titlebarheight"]=ac[cid]["deco_h"]
      }

    break

    case "num":
      ac[cid][key]=$NF
      cwsid=cid # current workspace id
      copid=outputs[ac[cid]["output"]] # current output id

      if (cid == i3fyra_workspace_id)
        i3fyra_workspace_num=$NF
    break

    case "focused":
      ac[cid][key]=$NF
      if ($NF == "true") {
        active_container_id=cid
        active_output_id=copid

        # the workspace container is focused
        # when there are no other windows visible
        if (ac[cid]["type"] == "\"workspace\"")
          active_workspace_id=cid
        else
          active_workspace_id=cwsid

      }
      ac[cid]["workspace"]=cwsid
      ac[cid]["parent"]=current_parent_id
    break

    case "window":
      if ($NF != "null") {

        ac[cid]["window"]=$NF
        ac[cid]["i3fyracontainer"]=current_i3fyra_container

        if ( (key in arg_search && $NF == arg_search[key]) || 
             ("i3fyracontainer" in arg_search && arg_search["i3fyracontainer"] == current_i3fyra_container) )
        {
          suspect_targets[cid]=1
        }
      }
    break

    case "floating":
      # TODO: i3get -> ac[cid]["floating"]=$NF
      # is this necessary?
      ac[cid]["floating-i3get"]=$NF
      ac[cid]["floating"]=($NF ~ /_on"$/ ? 1 : 0)

      if ( current_i3fyra_container in fyra_containers && fyra_containers[current_i3fyra_container]["id"] == cid)
      {
        current_i3fyra_container=""
      }
        
    break

    case "focus":
      if ($2 != "[]") {
        # a not empty focus list is the first thing
        # we encounter after a branch. The first
        # item of the list is the focused container
        # which is of interest if the container is
        # tabbed or stacked, where only the focused container
        # is visible.
        first_id=gensub(/[^0-9]/,"","g",$2)
        parent_id=ac[first_id]["parent"]
        ac[parent_id]["focused"]=first_id

        # this restores current_parent_id  and cid 
        # to what it was before this branch.
        cid=parent_id
        current_parent_id=ac[parent_id]["parent"]

        # below is only needed by viswiz

        # workspaces are childs in a special containers
        # named "content", so the focused (first_id) container
        # is a visible workspace (excluding the scratchpad)
        if (ac[parent_id]["name"] ~ /"content"/ &&
            ac[first_id]["name"] !~ /"__i3_scratch"/) {
          visible_workspaces[first_id]=1

          # store the workspace number for current output
          ac[copid]["num"]=ac[first_id]["num"]
        }

        # this just store a list of child container IDs
        # (same as the focus list).
        for (gotarray=0; !gotarray; getline) {
          child=gensub(/[][]/,"","g",$NF)
          ac[parent_id]["children"][child]=1
          gotarray=($NF ~ /[]]$/ ? 1 : 0)
        }

        # if the ACTIVE container is one of the children
        # get the order 
        if (active_container_id in ac[parent_id]["children"]) {

          groupsize=length(ac[parent_id]["children"])

          i=0 ; indx=0

          while (i<groupsize) {
            if (container_order[++indx] in ac[parent_id]["children"]) {
              curry=container_order[indx]

              if (++i==1)
                print_us["firstingroup"]=curry
              if (curry == active_container_id)
                print_us["grouppos"]=i

            }
          }
          
          print_us["lastingroup"]=curry
          print_us["grouplayout"]=ac[parent_id]["layout"]
          print_us["groupid"]=parent_id
          print_us["groupsize"]=groupsize
          getorder=0
        }
      }
    break

    case "marks":

      ac[cid][key]=$NF

      if ($NF == "[]")
        break

      if ( key in arg_search && match($NF, "\"" arg_search[key] "\"") )
        suspect_targets[cid]=1

      if ( match($NF,/"i34([ABCD])"/,ma) ) {
        current_i3fyra_container=ma[1]
        fyra_containers[ma[1]]["id"]=cid
        fyra_containers[ma[1]]["workspace"]=cwsid
        ac[cid]["i3fyra_mark"]=ma[1]

        if (cwsid != scratchpad_id) {
          fyra_containers[ma[1]]["visible"]=1
          fyra_containers[ma[1]]["family"]=current_fyra_family
        }
      }

      else if ( match($NF,/"i34X([ABCD]{2})"/,ma) ) {
        fyra_splits[ma[1]]=cid
        current_fyra_family=ma[1]
        fyra_vars["X" ma[1]]=ac[cwsid]["num"]
        fyra_vars["N" ma[1]]=ac[cwsid]["name"]
      }

      # marks set by i3var all are at the root_id.
      # all that are related to i3fyra has i34 prefix
      
      # "marks":["i34MAC=157"
      # "i34MAB=1570"
      # "i34MBD=252"
      # "i34FAC=X"
      # "i34FBD=X"
      # "hidden93845635698816="]
      else if (cid == root_id) {
        while (1) {
          # remove escaped doublequotes so things like
          # i3fyra_ws=\"Control Panel\"  , works
          # as expected.
          gsub(/\\"/,"",$0)
          match($0,/"(i3viswiz|i34)?([^"=]+)=([^"]*)"([]])?$/,ma)

          if (ma[2] == "i3fyra_ws")
            i3fyra_workspace_name=ma[3]
          else if (ma[1] == "i3viswiz")
            last_direction_id=ma[3]
          else if (ma[2] == "focus_wrap")
            focus_wrap=ma[3]
          else if (ma[1] == "i34")
            fyra_vars[ma[2]]=ma[3]
          if (ma[4] ~ "]")
            break
          
          getline
        }
      }

      # store all marks, for i3get
      else
      {
        while (1) {
          match($0,/"([^"]+)"([]])?$/,ma)
          ac[cid][key] = ( ac[cid][key] ? ac[cid][key] "," : "[" ) "\"" ma[1] "\""
          if (ma[2] ~ "]")
            break

          getline
        }

        ac[cid][key] = ac[cid][key] "]"
      }

    break
  }
}
