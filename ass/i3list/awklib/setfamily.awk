function setfamily(thiscon,type) {

  for (f in fam) {
    for (c in fam[f]) {
      if (fam[f][c] == thiscon) {
        window[type][type"FT"]=fam[f*-1][c]
        window[type][type"FC"]=fam[f*-1][c*-1]
        window[type][type"FS"]=fam[f][c*-1]
        window[type][type"FF"]=fam[f][1] fam[f][-1]
        window[type][type"FO"]=fam[f*-1][1] fam[f*-1][-1]
      }
    }
  }
}
