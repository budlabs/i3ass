#!/bin/bash

make_regex() {

local re

re+=$(cat << EOB
(\{)
"change":"(new|close|title)",
"container":[{]
"id":([0-9]+),
"type":"[^"]+",
"orientation":"[^"]+",
"scratchpad_state":"[^"]+",
"percent":[0-9.]+,
"urgent":(false|true),
("marks":(\[[^]]*\]),)?
"focused":(true|false),
"output":"[^"]+",
"layout":"[^"]+",
"workspace_layout":"[^"]+",
"last_split_layout":"[^"]+",
"border":"[^"]+",
"current_border_width":[0-9-]+,
"rect":[{]"x":([0-9]+),"y":([0-9]+),"width":([0-9]+),"height":([0-9]+)},
"deco_rect":[^g]+ght":([0-9]+)},
"window_rect":[^}]+},
"geometry":[^}]+},
"name":"?([^\"]+)"?,
("title_format":"([^"]+)",)?
"window_icon_padding":[^,]+,
"window":(${_c[id]:-[0-9]+}),
"window_type":"([^"]+)",
"window_properties":\{
("class":"([^"]+)",)?
("instance":"([^"]+)",)?
("window_role":"([^"]+)",)?
[^}]+\},
"nodes":[^,]+,
"floating_nodes":[^,]+,
"focus":[^,]+,
"fullscreen_mode":([0-9]),
"sticky":(false|true),
"floating":"([^"]+)",
("swallows":.+)?
EOB
)

# remove all newline characters
echo "${re//$'\n'/}"
}
