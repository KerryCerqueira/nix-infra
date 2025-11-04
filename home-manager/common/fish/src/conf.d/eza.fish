set -g moor_opts --quit-if-one-screen --no-clear-on-exit --no-statusbar

set -g eza_common_opts \
	--group-directories-first \
	--git-repos \
	--git \
	--header \
	--colour-scale \
	--mounts \
	--colour=always \
	--icons=always

set -g eza_base_opts $eza_common_opts --no-permissions --no-user
set -g eza_long_opts $eza_common_opts --header --long
set -g eza_llong_opts $eza_long_opts --modified --created --changed --group

function ls
    command eza $eza_base_opts --icons --colour $argv
end

function ll
    command eza $eza_long_opts $argv | moor $moor_opts
end

alias la="ll -a"

function lll
    command eza $eza_llong_opts $argv | moor $moor_opts
end

function lt
    set -l opts $eza_base_opts --tree --level=2
    command eza $opts $argv | moor $moor_opts
end

function llt
    set -l opts $eza_long_opts --tree --level=2
    command eza $opts $argv | moor $moor_opts
end

function lllt
    set -l opts $eza_llong_opts --tree --level=2
    command eza $opts $argv | moor $moor_opts
end

function ltt
    set -l opts $eza_base_opts --tree --level=3
    command eza $opts $argv | moor $moor_opts
end

function lltt
    set -l opts $eza_long_opts --tree --level=3
    command eza $opts $argv | moor $moor_opts
end

function llltt
    set -l opts $eza_llong_opts --tree --level=3
    command eza $opts $argv | moor $moor_opts
end

function lT
    set -l opts $eza_base_opts --tree
    command eza $opts $argv | moor $moor_opts
end

function llT
    set -l opts $eza_long_opts --tree
    command eza $opts $argv | moor $moor_opts
end

function lllT
    set -l opts $eza_llong_opts --tree
    command eza $opts $argv | moor $moor_opts
end
