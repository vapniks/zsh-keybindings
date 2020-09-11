#!/usr/bin/env zsh

## The functions defined in this file can be used for quickly testing & changing keybindings

# for testing terminfo key codes; 1st arg is a terminfo key, 2nd arg is a string (bindti2str) or widget (bindti2w)
function bindti2str() {
    bindkey -s "${terminfo[${1}]}" "${2}"
}
function bindti2w() {
    bindkey "${terminfo[${1}]}" "${2}"
}
compdef "compadd ${(k)terminfo[(I)k*]}" bindti2str
compdef "_arguments '1:terminfo:(${(k)terminfo[(I)k*]})' '2:widget:_widgets'" bindti2w
alias ti2s=bindti2str
alias ti2w=bindti2w
# show key codes defined in terminfo database
function showterminfokeys() {
    local key val thing
    for key val in ${(kv)terminfo[(I)k*]}; do
	for thing in "${key}" "${val}"; do
	    echo -n "${thing}" | od -a -A n -w4096 | sed 's/esc/^[/g' | tr -d ' '
	done | paste - -
    done
}
# show all keys bound to a given widget
function showidgetkeys() {
    bindkey|grep "${1}"|awk '{print $1}'
}
compdef _widgets showidgetkeys
alias sw=showidgetkeys
# print string representation of a char code
function printccode() {
    printf ${1}|od -a -A n -w4096|sed 's/esc/^[/g'|tr -d ' '
}
# show widget/string bound to a given key
function showkeybinding() {
    bindkey|grep -F "${1}"|awk '{print $2}'
}
alias sk=showkeybinding
# show widget/string bound to a given terminfo keycode
function showtikeybinding() {
    bindkey|grep -F $(printccode ${terminfo[${1}]})|awk '{print $2}'
}
alias skti=showtikeybinding
compdef "compadd ${(k)terminfo[(I)k*]}" showtikeybinding
# unbind all keys bound to a given widget
function unbindkeys() {
    local key
    for key in $(showkeys ${1}); do
	eval "bindkey -r ${key}"
    done
}
compdef _widgets unbindkeys
