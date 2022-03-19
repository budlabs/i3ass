#!/bin/bash

verbose_outro() {
  ERM $'\n'"------ theme start ------"
  themefile >&2
  ERM "------ theme end ------"
  ERM $'\n'"cmd: ${_menu_command[*]}"
}
