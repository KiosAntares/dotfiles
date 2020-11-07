# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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

# Only enable powerlevel10k prompt if in terminal emulator
[[ "$TERM" != "screen" && "$TERM" != "linux" ]] && source /usr/share/powerlevel10k/powerlevel10k.zsh-theme

# remap ls and editor
alias lls='ls'
alias ls='lsd'
alias vim='nvim'

# never used this
alias lsl='lsd -1'
alias lsa='lsd -a'
alias lsla='lsd -1a'

#date
alias fdate="date \"+%Y-%m-%d_%H:%M\""

# update
alias pacup='yay -Syu --noconfirm'

# refresh mirrors
alias mirrors='sudo reflector --f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist'

# coloured greps
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# add useful flags
alias cp='cp -i'
alias df='df -h'

# top cpu usage
alias pscpu='ps au | sort -nr -k 3'


# termbin alias
alias termbin='nc termbin.com 9999'
alias icat='kitty +kitten icat'
alias tlmgr='TEXMFDIST/scripts/texlive/tlmgr.pl --usermode'

# Force rebind of home, end and delete
bindkey "^[[H" beginning-of-line
bindkey "^[[3~" delete-char
bindkey "^[[F" end-of-line

# Reconfigure p10k if file missing
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Run ufetch if only one termemu is running
if [[ $(ps aux | grep kitty | grep -v "grep" | wc -l) == "1" ]]
then
    ufetch
fi
# Add many things to PATH
# Add i386 Cross compiler to path
# add emacs bin
# add local bin
# add cargo
export PATH=~/.emacs.d/bin/:~/.local/bin/:/usr/local/i386elfgcc/bin:/home/kios/.cargo/bin:$PATH


