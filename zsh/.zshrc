# SPDX-License-Identifer: MIT

# A pretty good Zsh config
# Copyright © 2025 AlphaLynx <alphalynx@protonmail.com>

## [Start] Zsh Configuration
autoload -Uz compinit
compinit

# Use XDG dirs for completion
[ -d "$XDG_STATE_HOME"/zsh ] || mkdir -p "$XDG_STATE_HOME"/zsh
HISTFILE="$XDG_STATE_HOME"/zsh/history
[ -d "$XDG_CACHE_HOME"/zsh ] || mkdir -p "$XDG_CACHE_HOME"/zsh
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME"/zsh/zcompcache
compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-$ZSH_VERSION

HISTSIZE=10000
SAVEHIST=10000000
setopt autocd
setopt complete_aliases
setopt histignorealldups
unsetopt beep
bindkey -v
## [End]   Zsh Configuration

## [Start] Environment Variables
export DIFFPROG='nvim'
export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'

# The following line is taken from the Arch Linux Wiki (https://wiki.archlinux.org/title/Sudo#Colored_password_prompt) under the GFDL-1.3-or-later license
export SUDO_PROMPT="$(tput setab 1 setaf 7 bold)[sudo]$(tput sgr0) $(tput setaf 6)password for$(tput sgr0) $(tput setaf 5)%p$(tput sgr0): "

export FZF_DEFAULT_COMMAND='fd --hidden --strip-cwd-prefix --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type=d --hidden --strip-cwd-prefix --exclude .git'

# XDG Base Directory Specification
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export GOPATH="$XDG_DATA_HOME"/go
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export NVM_DIR="$XDG_DATA_HOME"/nvm
export PYTHON_HISTORY="$XDG_STATE_HOME"/python/history
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
## [End]   Environment Variables

## [Start] Aliases
alias backup="rsync -arxvP --no-compress --exclude-from=$XDG_DATA_HOME/.backup-exclude.txt $HOME/ $HOME/mnt/extra/backup/home/"
alias cat='bat -pp'
alias cd='z'
alias cl='clear'
alias fd='fd -u'
alias fetch='fastfetch'
alias ls='eza'
alias l='eza'
alias ll='eza --all --long --git'
alias paru='nice -n -19 paru'
alias py='python'
alias rm='rm -I'
alias src='source'
alias sudo='sudo '
alias tree='eza --tree'
alias vim='nvim'
alias v='nvim'
alias wget="wget --hsts-file=$XDG_STATE_HOME/wget/hsts"
alias which='which -a'
alias x='exit'

# git
alias ga='git add'
alias gb='git branch'
alias gcl='git clone'
alias gcm='git commit -m'
alias gco='git checkout'
alias gd='git diff'
alias gi='git init'
alias gl='git log'
alias gp='git push'
alias gpl='git pull'
alias gs='git status'
## [End]   Aliases

## [Start] Functions

# The following function is taken from the Arch Linux Wiki (https://wiki.archlinux.org/title/Zsh#pacman_-F_%22command_not_found%22_handler) under the GFDL-1.3-or-later license
function command_not_found_handler {
    local purple='\e[1;35m' bright='\e[0;1m' green='\e[1;32m' reset='\e[0m'
    printf 'zsh: command not found: %s\n' "$1"
    local entries=(
        ${(f)"$(/usr/bin/pacman -F --machinereadable -- "/usr/bin/$1")"}
    )
    if (( ${#entries[@]} ))
    then
        printf "${bright}$1${reset} may be found in the following packages:\n"
        local pkg
        for entry in "${entries[@]}"
        do
            # (repo package version file)
            local fields=(
                ${(0)entry}
            )
            if [[ "$pkg" != "${fields[2]}" ]]
            then
                printf "${purple}%s/${bright}%s ${green}%s${reset}\n" "${fields[1]}" "${fields[2]}" "${fields[3]}"
            fi
            printf '    /%s\n' "${fields[4]}"
            pkg="${fields[2]}"
        done
    fi
    return 127
}
## [End]   Functions

## [Start] Load external scripts
# fzf
source <(fzf --zsh)
# nvm
[ -s '/usr/share/nvm/init-nvm.sh' ] && source '/usr/share/nvm/init-nvm.sh'
# oh-my-posh
eval "$(oh-my-posh init zsh)"
# zsh-autosuggestions
[ -s '/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh' ] && source '/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh'
# zsh-syntax-highlighting
[ -s '/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' ] && source '/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh'
# zoxide
eval "$(zoxide init zsh)"
## [End]   Load external scripts
