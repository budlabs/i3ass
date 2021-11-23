function find_window(direction,
                     trgx,trgy,
                     aww,awh,awx,awy,
                     wsw,wsh,wsx,wsy,
                     opx,opy,opw,oph,
                     rootx,rooty,rootw,rooth,
                     opid,workspace_id,
                     found,wall)
{
  wsx=ac[active_workspace_id]["x"]; wsy=ac[active_workspace_id]["y"]
  wsw=ac[active_workspace_id]["w"]; wsh=ac[active_workspace_id]["h"]

  awx=ac[active_container_id]["x"]; awy=ac[active_container_id]["y"]
  aww=ac[active_container_id]["w"]; awh=ac[active_container_id]["h"]

  opx=ac[active_output_id]["x"]; opw=ac[active_output_id]["w"]
  opy=ac[active_output_id]["y"]; oph=ac[active_output_id]["h"]

  rootx=ac[container_order[1]]["x"]; rootw=ac[container_order[1]]["w"]
  rooty=ac[container_order[1]]["y"]; rooth=ac[container_order[1]]["h"]

  trgx=(direction == "r" ? awx+aww+arg_gap :
        direction == "l" ? awx-arg_gap     :
        awx+(aww/2)+arg_gap )

  trgy=(direction == "d" ? awy+awh+arg_gap :
        direction == "u" ? awy-arg_gap     :
        awy+(awh/2)-arg_gap )

  found=0
  wall="none"

  if ( (direction == "r" && trgx > wsx+wsw) ||
       (direction == "l" && trgx < wsx) ) {

    wall=(direction == "l" ? "left" : "right")

    # invert direction
    direction=(direction == "l" ? "r" : "l")

    if (focus_wrap == "workspace") {

      trgx=(direction == "r" ? wsx+wsw-arg_gap :
                               wsx+arg_gap)

      wall=wall "-workspace"
    }

    else if ( (direction == "l" && trgx > rootx+rootw) ||
              (direction == "r" && trgx < rootx) ) {

      trgx=(direction == "r" ? rootx+rootw-arg_gap :
                               rootx+arg_gap)

      wall=wall "-area"
    } else
      wall=wall "-workspace"
  }

  else if ( (direction == "u" && trgy < wsy) ||
            (direction == "d" && trgy > wsy+wsh) ) {

    wall=(direction == "u" ? "up" : "down")

    trgy=(direction == "d" ? opy+oph+arg_gap :
          direction == "u" ? opy-arg_gap     :
          awy+(awh/2)-arg_gap )

    # invert direction
    direction=(direction == "u" ? "d" : "u")

    if (focus_wrap == "workspace") {

      trgy=(direction == "d" ? wsy+wsh-arg_gap :
                               wsy+arg_gap )

      wall=wall "-workspace"
    }

    else if ( (direction == "d" && trgy < rooty) ||
              (direction == "u" && trgy > rooty+rooth) ) {

      trgy=(direction == "d" ? rooty+rooth-arg_gap :
                               rooty+arg_gap )

      wall=wall "-area"
    } else 
      wall=wall "-workspace"
  }

  if ( last_direction_id in visible_containers ) {

    # last_direction is set by i3var (a mark)
    # so if it is visible we prioritize focusing that
    # if it is adjacent in target direction

    lwx=ac[last_direction_id]["x"]; lwy=ac[last_direction_id]["y"]
    lww=ac[last_direction_id]["w"]; lwh=ac[last_direction_id]["h"]

    switch (direction) {
      case "d":
      case "u":

        if ( (direction == "d" && lwy < awy+awh) ||
             (direction == "u" && lwy+lwh > awy) )
          break

        if ( is_container_at_pos(last_direction_id, lwx, trgy) &&
           ( is_container_at_pos(active_container_id, lwx, awy) ||
             is_container_at_pos(active_container_id, lwx+lww, awy) ) ) {
          found=last_direction_id
        }
      break

      case "r":
      case "l":

        if ( (direction == "r" && lwx < awx+aww) ||
             (direction == "l" && lwx+lww > awx) )
          break

        if ( is_container_at_pos(last_direction_id, trgx, lwy) &&
           ( is_container_at_pos(active_container_id, awx, lwy) ||
             is_container_at_pos(active_container_id, awx, lwy+lwh) ) ) {
          found=last_direction_id
        }
      break
    }
  }

  if (found == 0 && wall != "none") {
    if (direction ~ /l|r/) {
      for (workspace_id in visible_workspaces) {
        # on each workspace try a temporary target y
        # at the middle of the workspace
        tmpy=ac[workspace_id]["y"]+(ac[workspace_id]["h"]/2)-arg_gap
        # test if this temp y position exist both on
        # the current and active workspace (they are aligned)
        # and that trgx exist on current workspace (its aligned to the left)
        if (  is_container_at_pos(workspace_id, trgx, tmpy) && 
              is_container_at_pos(active_output_id, opx, tmpy)) {
          # if trgy is not on the next output
          # set it at the middle (tmpy)
          if (!is_container_at_pos(workspace_id, trgx, trgy))
            trgy=tmpy

          found=1
          break
        }
      }
      trgx=(found == 1 ? trgx : (direction == "l" ? wsx : wsx+wsw))
    }

    else if (direction ~ /u|d/) {

      # make sure trgy is outside active output
      # and not just the workspace (top|bottombars)
      if (wall ~ /workspace/)
        trgy=(direction == "d" ? opy-arg_gap : opy+oph+arg_gap)

      for (workspace_id in visible_workspaces) {
        output_id=outputs[ac[workspace_id]["output"]]
        # on each workspace try a temporary target x
        # at the middle of the output
        tmpx=ac[output_id]["x"]+(ac[output_id]["w"]/2)+arg_gap

        # test if this temp x position also exist on active output
        # test if both the x and y position exist on current output
        if (  is_container_at_pos(output_id, tmpx, trgy) && 
              is_container_at_pos(active_output_id,tmpx, opy)) {
          # set the target y according to the workspace
          # incase the output has a bottombar
          trgy=(direction == "d" ? 
                  ac[workspace_id]["y"]+ac[workspace_id]["h"]-arg_gap :
                  ac[workspace_id]["y"]+arg_gap )
          
          # if trgx is not on the next workspace
          # set it at the middle (tmpx)
          if (!is_container_at_pos(workspace_id, trgx, trgy))
            trgx=tmpx

          found=1
          break
        }
      }
      trgy=(found == 1 ? trgy : (direction == "d" ? wsy : wsy+wsh))
    }
  }

  print_us["wall"]=wall
  print_us["trgx"]=trgx ; print_us["trgy"]=trgy
  print_us["sx"]=wsx ; print_us["sy"]=wsy
  print_us["sw"]=wsw ; print_us["sh"]=wsh

  if (found > 1)
    return found

  for (conid in visible_containers) {
    if (is_container_at_pos(conid, trgx, trgy))
      return conid
  }
}
