END {

  if (length(arg_search))
  {
    for (suspect_id in suspect_targets) {

      search_match=0

      for (search in arg_search) { 
        if (match(ac[suspect_id][search],arg_search[search]))
          search_match+=1
      }

      if (search_match == length(arg_search)) {
        target_container_id=suspect_id
        break
      }
    }
  }
  else
    target_container_id=active_container_id

  if (! target_container_id)
    exit

  split(arg_print,toprint,"")
  format = arg_print_format

  for (k in toprint) {
    switch(toprint[k]) {

      case "t":
        k = "title"
        v = gensub(/^"|"$/,"","g",ac[target_container_id]["name"])
        out = gensub(/%v/,v,"g",format)
        out = gensub(/%k/,k,"g",out)
        printf ("%s", out)
      break

      case "c":
        k = "class"
        v = gensub(/^"|"$/,"","g",ac[target_container_id]["class"])
        out = gensub(/%v/,v,"g",format)
        out = gensub(/%k/,k,"g",out)
        printf ("%s", out)
      break

      case "i":
        k = "instance"
        v = gensub(/^"|"$/,"","g",ac[target_container_id]["instance"])
        out = gensub(/%v/,v,"g",format)
        out = gensub(/%k/,k,"g",out)
        printf ("%s", out) 
      break

      case "d":
        k = "win_id"
        v = ac[target_container_id]["window"]
        out = gensub(/%v/,v,"g",format)
        out = gensub(/%k/,k,"g",out)
        printf ("%s", out)
      break

      case "n":
        k = "con_id"
        v = target_container_id
        out = gensub(/%v/,v,"g",format)
        out = gensub(/%k/,k,"g",out)
        printf ("%s", out)
      break

      case "m":
        k = "marks"
        v = ac[target_container_id]["marks"]
        out = gensub(/%v/,v,"g",format)
        out = gensub(/%k/,k,"g",out)
        printf ("%s", out)
      break

      case "w":
        if (ac[target_container_id]["type"] ~ "workspace")
          target_workspace_id = target_container_id
        else
          target_workspace_id = ac[target_container_id]["workspace"]
        k = "ws number"
        v = ac[target_workspace_id]["num"]
        out = gensub(/%v/,v,"g",format)
        out = gensub(/%k/,k,"g",out)
        printf ("%s", out)
      break

      case "W":
        if (ac[target_container_id]["type"] ~ "workspace")
          target_workspace_id = target_container_id
        else
          target_workspace_id = ac[target_container_id]["workspace"]
        k = "ws name"
        v = gensub(/^"|"$/,"","g",ac[target_workspace_id]["name"])
        out = gensub(/%v/,v,"g",format)
        out = gensub(/%k/,k,"g",out)
        printf ("%s", out)
      break

      case "a":
        k = "focused"
        v = gensub(/^"|"$/,"","g",ac[target_container_id]["focused"])
        out = gensub(/%v/,v,"g",format)
        out = gensub(/%k/,k,"g",out)
        printf ("%s", out)
      break

      case "f":
        k = "floating"
        v = gensub(/^"|"$/,"","g",ac[target_container_id]["floating-i3get"])
        out = gensub(/%v/,v,"g",format)
        out = gensub(/%k/,k,"g",out)
        printf ("%s", out)
      break

      case "o":
        k = "title-format"
        v = gensub(/^"|"$/,"","g",ac[target_container_id]["title_format"])
        out = gensub(/%v/,v,"g",format)
        out = gensub(/%k/,k,"g",out)
        printf ("%s", out)
      break

      case "e":
        k = "fullscreen"
        v = ac[target_container_id]["fullscreen_mode"]
        out = gensub(/%v/,v,"g",format)
        out = gensub(/%k/,k,"g",out)
        printf ("%s", out)
      break

      case "s":
        k = "sticky"
        v = ac[target_container_id]["sticky"]
        out = gensub(/%v/,v,"g",format)
        out = gensub(/%k/,k,"g",out)
        printf ("%s", out) 
      break

      case "u":
        k = "urgent"
        v = ac[target_container_id]["urgent"]
        out = gensub(/%v/,v,"g",format)
        out = gensub(/%k/,k,"g",out)
        printf ("%s", out)
      break

      case "y":
        k = "type"
        v = gensub(/^"|"$/,"","g",ac[target_container_id]["window_type"])
        out = gensub(/%v/,v,"g",format)
        out = gensub(/%k/,k,"g",out)
        printf ("%s", out)
      break

      case "r":
        k = "role"

        if ("window_role" in ac[target_container_id])
          v = gensub(/^"|"$/,"","g",ac[target_container_id]["window_role"])
        else
          v = "unknown"

        out = gensub(/%v/,v,"g",format)
        out = gensub(/%k/,k,"g",out)
        printf ("%s", out)
      break
    }
  }
}
