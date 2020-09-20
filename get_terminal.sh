#!/bin/sh
# Return the terminal emulator that this shell is running in
set -f
pid=$PPID
my_tty=$(ps -p $$ -o tty=)
while
  [ "$pid" -ne 1 ] &&
  set -- $(ps -p "$pid" -o ppid= -o tty= -o args=) &&
  [ "$2" = "$my_tty" ]
do
    pid=$1
done

case "$3" in
    *tmux*)
	tmuxpid=$(tmux display-message -p "#{client_pid}")
	printf '%s\n' "$(ps -p $(ps -p $(ps -p $tmuxpid -o sid=) -o ppid=) -o args=)" ;;
    *)
	shift; shift
	printf '%s\n' "$*";;
esac

