export PATH="/usr/local/bin:$PATH"
[[ -d "$HOME/bin" ]] && export PATH="$HOME/bin:$PATH"
export ANDROID_SDK_ROOT="$HOME/Library/Android/sdk"
export PATH="$PATH:$ANDROID_SDK_ROOT/emulator:$ANDROID_SDK_ROOT/platform-tools":$ANDROID_SDK_ROOT/cmdline-tools/latest/bin

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="cloud"
CASE_SENSITIVE="true"
DISABLE_AUTO_UPDATE="true"
ZSH_DISABLE_COMPFIX="true"
plugins=(git zsh-autosuggestions macos rbenv ruby fast-syntax-highlighting)
fpath+=${ZSH_CUSTOM:-$ZSH/custom}/plugins/zsh-completions/src
source "$ZSH/oh-my-zsh.sh"
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
alias studio="open -a 'Android Studio.app'"
alias code="open -a 'Visual Studio Code.app'"
alias zed="/Applications/Zed.app/Contents/MacOS/cli -n"
alias ws="open -a 'WebStorm.app'"
alias rider="open -a 'Rider.app'"


# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
export EDITOR='nvim'
export VISUAL='nvim'
alias vim='nvim'
alias vi='nvim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
#
#

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# FNM
eval "$(fnm env --use-on-cd 2>/dev/null)" 2>/dev/null || true

export GOPATH="$HOME/go"
export PATH="$PATH:$HOME/go/bin"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d "$PYENV_ROOT/bin" ]] && export PATH="$PYENV_ROOT/bin:$PATH"
# lazy: full `pyenv init` costs ~150ms. Shims stay on PATH so python/pip work
# immediately; the real init runs only when you actually invoke `pyenv`.
[[ -d "$PYENV_ROOT/shims" ]] && export PATH="$PYENV_ROOT/shims:$PATH"
pyenv() { unfunction pyenv; eval "$(command pyenv init -)"; pyenv "$@"; }


export PNPM_HOME="$HOME/Library/pnpm"
[[ -d "$PNPM_HOME" ]] && export PATH="$PNPM_HOME:$PATH"


alias idea="open -na 'IntelliJ IDEA.app' --args '$@'"



# Aliases
alias g='git'
compdef g=git
alias gst='git status'
compdef _git gst=git-status
alias gl='git pull'
compdef _git gl=git-pull
alias gup='git fetch && git rebase'
compdef _git gup=git-fetch
alias gp='git push'
compdef _git gp=git-push
gdv() { git diff -w "$@" | view - }
compdef _git gdv=git-diff
alias gc='git commit -v'
compdef _git gc=git-commit
alias gca='git commit -v -a'
compdef _git gca=git-commit
alias gco='git checkout'
compdef _git gco=git-checkout
alias gcm='git checkout master'
alias gb='git branch'
compdef _git gb=git-branch
alias gba='git branch -a'
compdef _git gba=git-branch
alias gcount='git shortlog -sn'
compdef gcount=git
alias gcp='git cherry-pick'
compdef _git gcp=git-cherry-pick
alias glg='git log --stat --max-count=5'
compdef _git glg=git-log
alias glgg='git log --graph --max-count=5'
compdef _git glgg=git-log
alias gss='git status -s'
compdef _git gss=git-status
alias ga='git add'
compdef _git ga=git-add
alias gm='git merge'
compdef _git gm=git-merge
alias grh='git reset HEAD'
alias grhh='git reset HEAD --hard'
alias branches="git branch -r | xargs -L1 git --no-pager show -s --oneline --author="$(git config user.name)""
# Git and svn mix
alias git-svn-dcommit-push='git svn dcommit && git push github master:svntrunk'
compdef git-svn-dcommit-push=git

alias gsr='git svn rebase'
alias gsd='git svn dcommit'
#
# Will return the current branch name
# Usage example: git pull origin $(current_branch)
#
function current_branch() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo ${ref#refs/heads/}
}

function current_repository() {

  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo $(git remote -v | cut -d':' -f 2)
}

# these aliases take advantage of the previous function
alias ggpull='git pull origin $(current_branch)'
compdef ggpull=git
alias ggpush='git push origin $(current_branch)'
compdef ggpush=git
alias ggpnp='git pull origin $(current_branch) && git push origin $(current_branch)'
compdef ggpnp=git
alias dockerstop="ps ax|grep -i docker|egrep -iv 'grep|com.docker.vmnetd'|awk '{print $1}'|xargs kill"
alias coffee="caffeinate -d -i -s -u"
alias claude="claude --dangerously-skip-permissions"
xcode-clean() {
  rm -rf ~/Library/Developer/Xcode/DerivedData
  rm -rf ~/Library/Developer/CoreSimulator/Caches
  rm -rf ~/Library/Caches/com.apple.dt.Xcode
  xcrun simctl delete unavailable
}

alias xcclean='xcode-clean'

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"

export PATH="$PATH:/Applications/Docker.app/Contents/Resources/bin"
fpath=("$HOME/.docker/completions" $fpath)
fpath=("$HOME/.local/share/zsh/site-functions" $fpath)   # sentry (must precede compinit)
autoload -Uz compinit
compinit -C
autoload -U +X bashcompinit && bashcompinit
command -v terragrunt &>/dev/null && complete -o nospace -C terragrunt terragrunt
export PATH="$HOME/.local/bin:$PATH"

# ── modern cli ────────────────────────────────────────────
# fzf: ctrl-r history, ctrl-t files, alt-c cd
source <(fzf --zsh)
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS="--height 45% --layout=reverse --border=rounded \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#a6e3a1,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

# zoxide: `z <partial>` jumps to frecent dirs, `zi` picks interactively
eval "$(zoxide init zsh)"

# eza (ls), bat (cat), btop (top)
alias ls='eza --icons --group-directories-first'
alias ll='eza --icons --group-directories-first -lh --git'
alias la='eza --icons --group-directories-first -lha --git'
alias lt='eza --icons --tree --level=2 --git-ignore'
alias cat='bat --paging=never'
alias top='btop'
alias lg='lazygit'
export BAT_THEME="Catppuccin Mocha"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

export PATH=$PATH:/Users/lukehowsam/.spicetify

# Added by sonarqube-cli installer
export PATH="$HOME/.local/share/sonarqube-cli/bin:$PATH"

# flashlight
export PATH="/Users/lukehowsam/.flashlight/bin:$PATH"


# Daily job-hunt dorks (find-jobs.mjs). Run `jobs` for the list, `jobs-open` to launch them.
alias jobs='node ~/find-jobs.mjs'
alias jobs-open='node ~/find-jobs.mjs --open'


# kimi-code
export PATH="/Users/lukehowsam/.kimi-code/bin:$PATH"
alias codex='codex --yolo'

export PATH=$PATH:$HOME/.maestro/bin

#Vega CLI
source "/Users/lukehowsam/vega/env"
