function print_workspace(t, container_id, key) {
  key="W" t "I"; printf(strfrm,key, container_id, desc[key])
  key="W" t "X"; printf(strfrm,key, ac[container_id]["x"], desc[key])
  key="W" t "Y"; printf(strfrm,key, ac[container_id]["y"], desc[key])
  key="W" t "W"; printf(strfrm,key, ac[container_id]["w"], desc[key])
  key="W" t "H"; printf(strfrm,key, ac[container_id]["h"], desc[key])

  
  key="W" t "N"; printf(strfrm,key, ac[container_id]["name"], desc[key])
  key="WS" t   ; printf(strfrm,key, ac[container_id]["num"], desc[key])
}
