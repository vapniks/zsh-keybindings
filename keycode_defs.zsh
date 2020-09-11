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
setkey2st        shiftf1           "\e[1;2P"
setkey2st        shiftf2           "\e[1;2Q"
setkey2st        shiftf3           "\e[1;2R"
setkey2st        shiftf4           "\e[1;2S"
setkey2st        shiftf5           "\e[15;2~"
setkey2st        shiftf6           "\e[17;2~"
setkey2st        shiftf7           "\e[18;2~"
setkey2st        shiftf8           "\e[19;2~"
setkey2st        shiftf9           "\e[20;2~"
setkey2st        shiftf10          "\e[21;2~"
setkey2st        shiftf11          "\e[23;2~"
setkey2st        shiftf12          "\e[24;2~"
setkey2st        ctrl              "^"
setkey2st        ctrlhome          "\e[1;5H"
setkey2st        ctrlend           "\e[1;5F"
setkey2st        ctrlinsert        "\e[2;5~"
setkey2st        ctrldelete        "\e[3;5~"
setkey2st        ctrlbackspace     "^H"
setkey2st        ctrlpgup          "\e[5;5~"
setkey2st        ctrlpgdown        "\e[6;5~"
setkey2st        ctrlleft          "\e[1;5D"
setkey2st        ctrlup            "\e[1;5A"
setkey2st        ctrldown          "\e[1;5B"
setkey2st        ctrlright         "\e[1;5C"
setkey2st        alt               "\e"
setkey2st        altf1             "\e[1;3P"
setkey2st        altf2             "\e[1;3Q"
setkey2st        altf3             "\e[1;3R"
setkey2st        altf4             ""
setkey2st        altf5             "\e[15;3~"
setkey2st        altf6             "\e[17;3~"
setkey2st        altf7             "\e[18;3~"
setkey2st        altf8             "\e[19;3~"
setkey2st        altf9             "\e[20;3~"
setkey2st        altf10            ""
setkey2st        altf11            "\e[23;3~"
setkey2st        altf12            "\e[24;3~"
setkey2st        althome           "\e[1;3H"
setkey2st        altend            "\e[1;3F"
setkey2st        altinsert         "\e[2;3~"
setkey2st        altdelete         "\e[3;3~"
setkey2st        altbackspace      "\e^?"
setkey2st        altenter          "\e^M"
setkey2st        altpgup           "\e[5;3~"
setkey2st        altpgdown         "\e[6;3~"
setkey2st        altleft           "\e[1;3D"
setkey2st        altup             "\e[1;3A"
setkey2st        altdown           "\e[1;3B"
setkey2st        altright          "\e[1;3C"
setkey2st        ctrlalthome       "\e[1;7H"
setkey2st        ctrlaltend        "\e[1;7F"
setkey2st        ctrlaltinsert     "\e[2;7~"
setkey2st        ctrlaltdelete     "\e[3;7~"
setkey2st        ctrlaltbackspace  "\e^H"
setkey2st        ctrlaltpgup       "\e[5;7~"
setkey2st        ctrlaltpgdown     "\e[6;7~"
setkey2st        ctrlaltleft       "\e[1;7D"
setkey2st        ctrlaltup         "\e[1;7A"
setkey2st        ctrlaltdown       "\e[1;7B"
setkey2st        ctrlaltright      "\e[1;7C"

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
		keys[altbackspace]="\e^?"
	    fi
	fi
	keys[altenter]=''
	keys[shiftpgup]=''
	keys[shiftpgdown]=''
	;;
    guake)
	echo "Running zsh under guake"
	keys[altleft]='\eb'
	keys[altright]='\ef'
	keys[ctrlleft]='\eb'
	keys[ctrlright]='\ef'
	keys[shiftpgup]='\e[5;2~'
	keys[shiftpgdown]='\e[6;2~'
	keys[ctrlinsert]=''
	keys[altf1]="\e\eOP"
	keys[altf2]="\e\eOQ"
	keys[altf3]="\e\eOR"
	keys[altf5]="\e\e[15~"
	keys[altf6]="\e\e[17~"
	keys[altf7]="\e\e[18~"
	keys[altf8]="\e\e[19~"
	keys[altf9]="\e\e[20~"
	keys[altf11]="\e\e[23~"
	keys[altf12]="\e\e[24~"
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
