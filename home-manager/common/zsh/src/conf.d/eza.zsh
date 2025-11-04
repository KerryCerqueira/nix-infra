MOOR_OPTS=(
	--quit-if-one-screen
	--no-clear-on-exit
	--no-statusbar
)
EZA_COMMON_OPTS=(
	--group-directories-first
	--git-repos
	--git
	--header
	--colour-scale
	--mounts
	--icons
	--colour
)
EZA_BASE_OPTS=(
	"${EZA_COMMON_OPTS[@]}"
	--no-permissions
	--no-user
)
EZA_PAGER_OPTS=(
	--colour=always
	--icons=always
)
EZA_LONG_OPTS=(
	"${EZA_COMMON_OPTS[@]}"
	"${EZA_PAGER_OPTS[@]}"
	--header
	--long
)
EZA_LLONG_OPTS=(
	"${EZA_LONG_OPTS[@]}"
	--modified
	--created
	--changed
	--group
)
function ls() {
	command eza "${EZA_BASE_OPTS[@]}" --icons --colour "$@"
}
function ll() {
	command eza "${EZA_LONG_OPTS[@]}" "$@" | moor "${MOOR_OPTS[@]}"
}
function lll() {
	command eza "${EZA_LLONG_OPTS[@]}" "$@" | moor "${MOOR_OPTS[@]}"
}
function lt() {
	OPTS=( "${EZA_BASE_OPTS[@]}" --tree --level=2)
	command eza "${OPTS[@]}" "$@" | moor "${MOOR_OPTS[@]}"
}
function llt() {
	OPTS=( "${EZA_LONG_OPTS[@]}" --tree --level=2)
	command eza "${OPTS[@]}" "$@" | moor "${MOOR_OPTS[@]}"
}
function lllt() {
	OPTS=( "${EZA_LONG_OPTS[@]}" --tree --level=2)
	command eza "${OPTS[@]}" "$@" | moor "${MOOR_OPTS[@]}"
}
function ltt() {
	OPTS=("${EZA_BASE_OPTS[@]}" --tree --level=3)
	command eza "${OPTS[@]}" "$@" | moor "${MOOR_OPTS[@]}"
}
function lltt() {
	OPTS=("${EZA_LONG_OPTS[@]}" --tree --level=3)
	command eza "${OPTS[@]}" "$@" | moor "${MOOR_OPTS[@]}"
}
function llltt() {
	OPTS=("${EZA_LLONG_OPTS[@]}" --tree --level=3)
	command eza "${OPTS[@]}" "$@" | moor "${MOOR_OPTS[@]}"
}
function lT() {
	OPTS=("${EZA_BASE_OPTS[@]}" --tree)
	command eza "${OPTS[@]}" "$@" | moor "${MOOR_OPTS[@]}"
}
function llT() {
	OPTS=("${EZA_LONG_OPTS[@]}" --tree)
	command eza "${OPTS[@]}" "$@" | moor "${MOOR_OPTS[@]}"
}
function lllT() {
	OPTS=("${EZA_LLONG_OPTS[@]}" --tree)
	command eza "${OPTS[@]}" "$@" | moor "${MOOR_OPTS[@]}"
}
compdef _eza ls
compdef _eza ll
compdef _eza lll
compdef _eza lt
compdef _eza llt
compdef _eza lllt
compdef _eza lT
compdef _eza llT
compdef _eza lllT
