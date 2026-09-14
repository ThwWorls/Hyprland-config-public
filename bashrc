#
# ~/.bashrc
#

[[ $- != *i* ]] && return

# ── Prompt ──
PS1='\[\e[0;37m\]\w\[\e[0m\] \[\e[0;90m\]>\[\e[0m\] '

# ── Aliases ──
alias ls='ls --color=auto'
alias ll='ls -lah --color=auto'
alias la='ls -A --color=auto'
alias grep='grep --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
alias cl='clear && fastfetch'
alias clear='command clear && fastfetch'
alias v='nvim'
alias vim='nvim'
alias ff='fastfetch'

# ── History ──
HISTSIZE=5000
HISTFILESIZE=10000
HISTCONTROL=ignoredups:erasedups
shopt -s histappend

# ── Misc ──
shopt -s checkwinsize
shopt -s autocd 2>/dev/null

# ── Fastfetch on new terminal ──
if command -v fastfetch &>/dev/null; then
    fastfetch
fi
