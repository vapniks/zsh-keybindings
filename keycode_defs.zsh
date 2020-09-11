#!/usr/bin/env zsh

## This file contains the definition of a "keys" assoc array associating key names with key codes which can then be used with
# bindkey, e.g: bindkey ${keys[altbackspace]} backward-kill-word
# Some terminal emulators emit different key codes or no key codes for some keys. These differences from the defaults can be
# set at the end of this file. The name of the terminal emulator will be exported in ${TERMINAL_EMULATOR}.
# The definitions assume that you have a ${terminfo[@]} assoc array set.
# The terminfo key code names can be found in the terminfo manpage.
# Note: by default xterm treats the Alt key as a modifier for inserting ligatures, diacritics or other unusual letters & symbols.
#       If you want xterm to treat the Alt key in the same way as other terminal emulators, i.e. as an ESC modifier, then
#       you need to set "XTerm.vt100.metaSendsEscape: true" in an Xresources file (e.g. ~/.Xresources), and then reload it
#       with xrdb.

#source keycode_fns.zsh

## inclusion guard
if [[ -n ${keys} && -n ${TERMINAL_EMULATOR} ]]; then
    return
fi

typeset -A keys
## Set default key codes from terminfo
function setkey2ti() {
    keys[${1}]="${terminfo[${2}]}"
}
setkey2ti	 f1		 kf1
setkey2ti	 f2		 kf2
setkey2ti	 f3		 kf3
setkey2ti	 f4		 kf4
setkey2ti	 f5		 kf5
setkey2ti	 f6		 kf6
setkey2ti	 f7		 kf7
setkey2ti	 f8		 kf8
setkey2ti	 f9		 kf9
setkey2ti	 f10		 kf10
setkey2ti	 f11		 kf11
setkey2ti        f12             kf12
setkey2ti        home            khome
setkey2ti        end             kend
setkey2ti	 insert		 kich1
setkey2ti	 delete		 kdch1
setkey2ti	 backspace	 kbs
setkey2ti        enter           kent
#setkey2ti        print           kprt
setkey2ti	 pgup		 kpp
setkey2ti	 pgdown		 knp
setkey2ti	 left		 kcub1
setkey2ti	 up		 kcuu1
setkey2ti	 down		 kcud1
setkey2ti	 right		 kcuf1
setkey2ti        shifthome       kHOM
setkey2ti        shiftend        kEND
setkey2ti        shiftdel        kDC
setkey2ti        shiftpgup       kPRV
setkey2ti        shiftpgdown     kNXT
setkey2ti        shiftleft       kLFT
setkey2ti        shiftright      kRIT
setkey2ti        shifttab        kcbt
setkey2ti        backtab         kcbt
# other key combinations
function setkey2st() {
    keys[${1}]="${2}"
}
setkey2st        shiftf1           "^[[1;2P"
setkey2st        shiftf2           "^[[1;2Q"
setkey2st        shiftf3           "^[[1;2R"
setkey2st        shiftf4           "^[[1;2S"
setkey2st        shiftf5           "^[[15;2~"
setkey2st        shiftf6           "^[[17;2~"
setkey2st        shiftf7           "^[[18;2~"
setkey2st        shiftf8           "^[[19;2~"
setkey2st        shiftf9           "^[[20;2~"
setkey2st        shiftf10          "^[[21;2~"
setkey2st        shiftf11          "^[[23;2~"
setkey2st        shiftf12          "^[[24;2~"
setkey2st        ctrl              "^"
setkey2st        ctrlhome          "^[[1;5H"
setkey2st        ctrlend           "^[[1;5F"
setkey2st        ctrlinsert        "^[[2;5~"
setkey2st        ctrldelete        "^[[3;5~"
setkey2st        ctrlbackspace     "^H"
setkey2st        ctrlpgup          "^[[5;5~"
setkey2st        ctrlpgdown        "^[[6;5~"
setkey2st        ctrlleft          "^[[1;5D"
setkey2st        ctrlup            "^[[1;5A"
setkey2st        ctrldown          "^[[1;5B"
setkey2st        ctrlright         "^[[1;5C"
setkey2st        alt               "^["
setkey2st        altf1             "^[[1;3P"
setkey2st        altf2             "^[[1;3Q"
setkey2st        altf3             "^[[1;3R"
setkey2st        altf4             ""
setkey2st        altf5             "^[[15;3~"
setkey2st        altf6             "^[[17;3~"
setkey2st        altf7             "^[[18;3~"
setkey2st        altf8             "^[[19;3~"
setkey2st        altf9             "^[[20;3~"
setkey2st        altf10            ""
setkey2st        altf11            "^[[23;3~"
setkey2st        altf12            "^[[24;3~"
setkey2st        althome           "^[[1;3H"
setkey2st        altend            "^[[1;3F"
setkey2st        altinsert         "^[[2;3~"
setkey2st        altdelete         "^[[3;3~"
setkey2st        altbackspace      "^[^?"
setkey2st        altenter          "^[^M"
setkey2st        altpgup           "^[[5;3~"
setkey2st        altpgdown         "^[[6;3~"
setkey2st        altleft           "^[[1;3D"
setkey2st        altup             "^[[1;3A"
setkey2st        altdown           "^[[1;3B"
setkey2st        altright          "^[[1;3C"
setkey2st        ctrlalthome       "^[[1;7H"
setkey2st        ctrlaltend        "^[[1;7F"
setkey2st        ctrlaltinsert     "^[[2;7~"
setkey2st        ctrlaltdelete     "^[[3;7~"
setkey2st        ctrlaltbackspace  "^[^H"
setkey2st        ctrlaltpgup       "^[[5;7~"
setkey2st        ctrlaltpgdown     "^[[6;7~"
setkey2st        ctrlaltleft       "^[[1;7D"
setkey2st        ctrlaltup         "^[[1;7A"
setkey2st        ctrlaltdown       "^[[1;7B"
setkey2st        ctrlaltright      "^[[1;7C"

## Work out what terminal emulator we are using
TERMINAL_EMULATOR="$(ps --pid $(ps --pid $$ -o ppid=) -o comm=)"
if [[ "${TERMINAL_EMULATOR}" =~ tmux ]]; then
    export TERMINAL_EMULATOR=${${$(ps --pid "$(($(ps --pid $(ps --pid $(tmux display-message -p "#{client_pid}") -o sid=) -o ppid=)))" -o comm=)## #}%% #}
else
    export TERMINAL_EMULATOR
fi

## Set deviations from default key codes, for different terminal emulators 
case "${TERMINAL_EMULATOR}"
in
    xterm)
	echo "Running zsh under xterm"
	keys[altbackspace]='ÿ'
	if [[ $(whence appres) ]]; then
	    if [[ "$(appres XTerm.VT100 xterm.vt100 -1|grep metaSendsEscape|head -1|awk '{print $2}')" == true ]]; then
		keys[altbackspace]="^[^?"
	    fi
	fi
	keys[altenter]=''
	keys[shiftpgup]=''
	keys[shiftpgdown]=''
	;;
    guake)
	echo "Running zsh under guake"
	keys[altleft]='^[b'
	keys[altright]='^[f'
	keys[ctrlleft]='^[b'
	keys[ctrlright]='^[f'
	keys[shiftpgup]='^[[5;2~'
	keys[shiftpgdown]='^[[6;2~'
	keys[ctrlinsert]=''
	keys[altf1]="^[^[OP"
	keys[altf2]="^[^[OQ"
	keys[altf3]="^[^[OR"
	keys[altf5]="^[^[[15~"
	keys[altf6]="^[^[[17~"
	keys[altf7]="^[^[[18~"
	keys[altf8]="^[^[[19~"
	keys[altf9]="^[^[[20~"
	keys[altf11]="^[^[[23~"
	keys[altf12]="^[^[[24~"
	keys[ctrlaltinsert]=''
	;;
    gnome-terminal)
	echo "Running zsh under gnome-terminal"
	keys[ctrlinsert]=''
	keys[shiftpgup]=''
	keys[shiftpgdown]=''
	keys[ctrlaltinsert]=''
	;;
esac
