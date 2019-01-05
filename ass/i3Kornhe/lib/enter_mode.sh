#!/usr/bin/env bash

enter_mode(){ 

  i3var set sizemode $__varmode
  i3var get sizetits || current_tf

  i3var set sizecon "${i3list[AWC]}"

  set_tf
  i3-msg -q mode sizemode

  exit
}
