function print_fyra_window(t, container_id, parent, key) {

  key=t "WP"; printf(strfrm,key, parent, desc[key])

  # desc["AFT"]="Active Window twin" 
  key=t "FT"; printf(strfrm,key,
    (parent == "A" ? ( orientation == "horizontal" ? "B" : "C") : 
     parent == "B" ? ( orientation == "horizontal" ? "A" : "D") :
     parent == "C" ? ( orientation == "horizontal" ? "D" : "A") :
     parent == "D" ? ( orientation == "horizontal" ? "C" : "B") : 0),
    desc[key])

  # desc["AFC"]="Active Window cousin" 
  key=t "FC"; printf(strfrm,key,
    (parent == "A" ? "D" : 
     parent == "B" ? "C" :
     parent == "C" ? "B" :
     parent == "D" ? "A" : 0),
    desc[key])

  # desc["AFS"]="Active Window sibling" 
  key=t "FS"; printf(strfrm,key,
    (parent == "A" ? ( orientation == "horizontal" ? "C" : "B") : 
     parent == "B" ? ( orientation == "horizontal" ? "D" : "A") :
     parent == "C" ? ( orientation == "horizontal" ? "A" : "D") :
     parent == "D" ? ( orientation == "horizontal" ? "B" : "C") : 0),
    desc[key])

  # desc["AFF"]="Active Window family"
  key=t "FF"; printf(strfrm,key,
    (parent == "A" ? ( orientation == "horizontal" ? "AC" : "AB") : 
     parent == "B" ? ( orientation == "horizontal" ? "BD" : "AB") :
     parent == "C" ? ( orientation == "horizontal" ? "AC" : "CD") :
     parent == "D" ? ( orientation == "horizontal" ? "BD" : "CD") : 0),
    desc[key])

  # desc["AFO"]="Active Window relatives"
  key=t "FO"; printf(strfrm,key,
    (parent == "A" ? ( orientation == "horizontal" ? "BD" : "CD") : 
     parent == "B" ? ( orientation == "horizontal" ? "AC" : "CD") :
     parent == "C" ? ( orientation == "horizontal" ? "BD" : "AB") :
     parent == "D" ? ( orientation == "horizontal" ? "AC" : "AB") : 0),
    desc[key])
}
