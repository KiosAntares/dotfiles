source /usr/share/zsh-theme-powerlevel9k/powerlevel9k.zsh-theme

alias lls='ls'
alias ls='lsd'
alias lsl='lsd -1'
alias lsa='lsd -a'
alias lsla='lsd -1a'

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status vi_mode)
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true

POWERLEVEL9K_DIR_DEFAULT_BACKGROUND='turquoise4'
POWERLEVEL9K_DIR_HOME_BACKGROUND='orange1'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND='turquoise4'

bindkey "^[[H" beginning-of-line
bindkey "^[[3~" delete-char
bindkey "^[[F" end-of-line
