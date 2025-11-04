function rerender_on_bind_mode_change --on-variable fish_bind_mode
	if test "$fish_bind_mode" != paste -a "$fish_bind_mode" != "$FISH__BIND_MODE"
		set -gx FISH__BIND_MODE $fish_bind_mode
		omp_repaint_prompt
	end
end
