#!/bin/bash

# https://kloudvm.com/uncategorized/detect-keyboard-keys-and-mouse-clicks-in-bash-scripts/

__ESC=$'\e'
__CSI=$'\e['

# Translate a String to a Key Name
function __translate_key()
{
  case $1 in
    "$__ESC" ) __ESC2KEY=ESC ;;
    "$__CSI"1~ | "$__CSI"[17]~ | "$__CSI"H ) __ESC2KEY=HOME ;;
    "$__CSI"2~ ) __ESC2KEY=INS ;;
    "$__CSI"3~ ) __ESC2KEY=DEL ;;
    "$__CSI"4~ | "$__CSI"[28]~ | "$__CSI"F ) __ESC2KEY=END ;;
    "$__CSI"5~ ) __ESC2KEY=PGUP ;;
    "$__CSI"6~ ) __ESC2KEY=PGDN ;;
    "$__CSI"A | ${__CSI}OA ) __ESC2KEY=UP ;;
    "$__CSI"B | ${__CSI}0B ) __ESC2KEY=DOWN ;;
    "$__CSI"C | ${__CSI}OC ) __ESC2KEY=RIGHT ;;
    "$__CSI"D | ${__CSI}OD ) __ESC2KEY=LEFT ;;
    "$__CSI"11~ | ${__ESC}OP | "$__CSI["A ) __ESC2KEY=F1 ;;
    "$__CSI"12~ | ${__ESC}OQ | "$__CSI["B ) __ESC2KEY=F2 ;;
    "$__CSI"13~ | ${__ESC}OR | "$__CSI["C ) __ESC2KEY=F3 ;;
    "$__CSI"14~ | ${__ESC}OS | "$__CSI["D ) __ESC2KEY=F4 ;;
    "$__CSI"15~ | "$__CSI["E ) __ESC2KEY=F5 ;;
    "$__CSI"17~ | "$__CSI["F ) __ESC2KEY=F6 ;;
    "$__CSI"18~ ) __ESC2KEY=F7 ;;
    "$__CSI"19~ ) __ESC2KEY=F8 ;;
    "$__CSI"20~ ) __ESC2KEY=F9 ;;
    "$__CSI"21~ ) __ESC2KEY=F10 ;;
    "$__CSI"23~ ) __ESC2KEY=F11 ;;
    "$__CSI"24~ ) __ESC2KEY=F12 ;;

    ## Everything else; add other keys before this line
    *) __ESC2KEY=UNKNOWN ;;
  esac
  [ -n "$2" ] && eval "$2=\$__ESC2KEY"
}


function get_key()
{
  local _v_ _w_ _x_ _y_ _z_ delay=${delay:-.0001}
  # reads the first character
  IFS= read -d '' -rsn1 _v_
  # waits for one-ten-thousandth of a second for another character
  read -sn1 -t "$delay" _w_
  read -sn1 -t "$delay" _x_
  read -sn1 -t "$delay" _y_
  read -sn1 -t "$delay" _z_
  keys="$_v_$_w_$_x_$_y_$_z_"
  case $_v_ in
    $'\n')
      printf -v ${1:?} ENTER ;;
    $'\e')
      __translate_key $keys # "$_v_$_w_$_x_$_y_$_z_"
      printf -v ${1:?} $__ESC2KEY
      ;;
    *)
      printf -v ${1:?} "%s" $keys # "$_v_$_w_$_x_$_y_$_z_"
      ;; 
  esac
}
