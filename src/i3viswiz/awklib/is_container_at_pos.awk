function is_container_at_pos(id, x, y,
                             csx,csy,cex,cey) 
{
  # topleft (start) # bottomright (end)
  csy=ac[id]["y"]   ; cey=csy+ac[id]["h"]
  csx=ac[id]["x"]   ; cex=csx+ac[id]["w"]

  return csx <= x && x <= cex && csy <= y && y <= cey
}
