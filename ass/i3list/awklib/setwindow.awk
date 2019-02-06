function setwindow(floats,type) {

  if (floats ~ /on$/) 
    window[type][type"WF"]=1
  else
    window[type][type"WF"]=0

  setworkspace(curwsid,type)
  window[type][type"WI"]=curwid
  window[type][type"WX"]=dim[curcid]["window"]["x"]
  window[type][type"WB"]=dim[curcid]["tab"]["height"]
  window[type][type"WY"]=(dim[curcid]["window"]["y"]-window[type][type"WB"])
  window[type][type"WW"]=dim[curcid]["window"]["width"]
  window[type][type"WH"]=(dim[curcid]["window"]["height"]+window[type][type"WB"])
  window[type][type"TX"]=dim[curcid]["tab"]["x"]
  window[type][type"TW"]=dim[curcid]["tab"]["width"]

  if(curcid == conta[curcon]["id"]){

    window[type][type"WP"]=curcon
    setfamily(curcon,type)

  }
}
