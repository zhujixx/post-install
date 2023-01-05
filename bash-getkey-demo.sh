#!/bin/bash

function __get_key_demo() {
  echo "Press a key ... q to exit"
  while :; do
    get_key key
    case $key in
      q|Q) break ;;
      UP) echo "UP";;
      LEFT) echo "LEFT";;
      F1) echo "F1";;
      *) echo $key
    esac
  done
}

__get_key_demo
