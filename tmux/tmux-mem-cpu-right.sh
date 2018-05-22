# Print out Memory, cpu and load using https://github.com/thewtex/tmux-mem-cpu-load

run_segment() {
	type $HOME/.tmux/plugins/tmux-mem-cpu-load/tmux-mem-cpu-load >/dev/null 2>&1
	if [ "$?" -ne 0 ]; then
		return
	fi

    stats=$($HOME/.tmux/plugins/tmux-mem-cpu-load/tmux-mem-cpu-load -c -q -i 2 -g 4 -m 2 -a 0)
	if [ -n "$stats" ]; then
		echo "$stats";
	fi
	return 0
}
