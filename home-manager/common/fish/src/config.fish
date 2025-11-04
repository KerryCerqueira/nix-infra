status is-login; and begin
end

status is-interactive; and begin
	oh-my-posh init fish --config $HOME/.config/oh-my-posh/config.json | source
end
