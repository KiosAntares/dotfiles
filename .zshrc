# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' group-name ''
zstyle ':completion:*' ignore-parents parent pwd ..
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' menu select=3
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' squeeze-slashes true
zstyle :compinstall filename '/home/kios/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory
unsetopt beep
setopt extendedglob
# End of lines configured by zsh-newuser-install
[[ "$TERM" != "screen" && "$TERM" != "linux" ]] && source /usr/share/powerlevel10k/powerlevel10k.zsh-theme

alias lls='ls'
alias ls='lsd'
alias lsl='lsd -1'
alias lsa='lsd -a'
alias lsla='lsd -1a'
alias icat='kitty +kitten icat'

# termbin alias
alias termbin='nc termbin.com 9999'

alias vim='nvim'

bindkey "^[[H" beginning-of-line
bindkey "^[[3~" delete-char
bindkey "^[[F" end-of-line

export PATH=~/.local/bin/:/usr/local/i386elfgcc/bin:/home/kios/.cargo/bin:$PATH

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


if [[ $(ps aux | grep kitty | grep -v "grep" | wc -l) == "1" ]]
then
    ufetch
fi
