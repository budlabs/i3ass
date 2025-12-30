## renamed i3fyra --rotate -> i3fyra --swap
Also added short option -S

## monocled status available in i3get and i3list

i3list has ACM and TCM (active/target container monocled)
and i3get has `--print M` , both commands will say
**1** if container is monocled, or **0** if it isn't

## add parent container ID to i3list output

desc["CAP"]="Container A Container ID"
desc["CBP"]="Container B Container ID"
desc["CCP"]="Container C Container ID"
desc["CDP"]="Container D Container ID"

## add first and last in each i3fyra container in i3list

desc["CFD"]="First container in D, container ID"
desc["CLD"]="Last container in D, container ID"

## new options for i3viswiz

new command line options: --offset-x, --offset-y, --force-wrap, --ignore-last

## bugfixes in shared awk script and viswiz awk

both related to finding current monitor and focus wrapping.
