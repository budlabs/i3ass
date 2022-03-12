#!/bin/bash

# timer is started in _init.sh before getopt

timer_stop() {
  ERM "<<< $___cmd" \
      "$(( (10#${EPOCHREALTIME//[!0-9]} - ___t) / 1000 ))ms"
}
