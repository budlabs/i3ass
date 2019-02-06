BEGIN {
  # sq contains a single quote for convenience
  sq = "'"
  
  # act|trg == 0: active/target window not found yet
  # act|trg == 1: active/target window in process
  # act|trg == 2: active/target window processed

  # hit !=0: inside i3fyra container

  act=trg=hit=0

  # set trg to processed if no criterion is given.
  # mirror active window to target before print.

  if (crit=="X") {trg=2}

  # define layout depending on orientation
  # splits[1] & splits[2] = families
  # splits[3] = main split
  
  if (ENVIRON["I3FYRA_ORIENTATION"]=="vertical") {
    splits[1]="AB"
    splits[2]="CD"
    splits[3]="AC"
  }
  else {
    splits[1]="AC"
    splits[2]="BD"
    splits[3]="AB" 
  }

  # fam array used to calculate relation between
  # containers in setfamily function.

  fam[1][1]   = substr(splits[1],1,1)
  fam[1][-1]  = substr(splits[1],2,1)
  fam[-1][1]  = substr(splits[2],1,1)
  fam[-1][-1] = substr(splits[2],2,1)

  # base layout array

  defaults[1]="A"
  defaults[2]="B"
  defaults[3]="C"
  defaults[4]="D"

}
