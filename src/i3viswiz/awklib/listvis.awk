function listvis(id,
                 stackh,trg)
{
  # searches container with con_id=id recursevely 
  # for visible containers, add them to the global
  # array: visible_containers
  if ("children" in ac[id]) {
    if (ac[id]["layout"] ~ /tabbed|stacked/) {
      trg=ac[id]["focused"]
      if (ac[id]["layout"] ~ /stacked/) {
        stackh=length(ac[id]["children"])
        ac[trg]["h"]+=(ac[trg]["titlebarheight"]*stackh)
        ac[trg]["y"]-=(ac[trg]["titlebarheight"]*stackh)
      }
      listvis(trg)
      # visible_containers[trg]=trg
    } else if (ac[id]["layout"] ~ /split/) {
      for (trg in ac[id]["children"]) {
        listvis(trg)
      }
    }
  } else if (!ac[id]["floating"]) {
    ac[id]["h"]+=ac[id]["titlebarheight"]
    ac[id]["y"]-=ac[id]["titlebarheight"]
    visible_containers[id]=id
  }
}
