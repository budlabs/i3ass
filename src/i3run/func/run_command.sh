#!/bin/bash

run_command() {
  ((_o[verbose])) && ERM "i3run -> $_command"
  eval "$_command" > /dev/null 2>&1 &
}
