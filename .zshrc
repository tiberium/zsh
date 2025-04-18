# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes

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

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

### ZSH Configuration ###
export ZSH_THEME="spaceship"
plugins=(
  zsh-autosuggestions
  git
  colored-man-pages
  kubectl
  # docker
  aws
  argocd
  colorize
  gradle
  poetry
  pyenv
  spaceship_gitemail
)

# Oh-my-zsh
source $ZSH/oh-my-zsh.sh

if [[ -z "$SPACESHIP_GITEMAIL_ADDED" ]]; then
  spaceship add gitemail
  SPACESHIP_GITEMAIL_ADDED=true
fi

# Syntax highlighting for zsh
[[ "$OSTYPE" == "darwin"* ]] && source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[[ "$OSTYPE" == "linux-gnu"* ]] && source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#

# Configure zsh history
export HISTSIZE=10000000
export SAVEHIST=10000000
setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST

# kubectl autocompletition
autoload -Uz compinit
compinit
source <(kubectl completion zsh)

# Nice PATH print
alias print-path="python -c 'import sys;print(sys.argv[1].replace(\":\",\"\\n\"))' \"\$PATH\""

# Gradle
alias G="./gradlew"
alias Gcb="./gradlew clean build --refresh-dependencies"

# pyenv configuration
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Load seperated config files
if [ -d "$HOME/.config/zsh/config.d" ]; then
  # Load all files in the directory
  for conf in "$HOME/.config/zsh/config.d/"*.zsh; do
    source "${conf}"
  done
fi
unset conf

# Set up fzf key bindings
# source <(fzf --zsh)

alias inv='nvim $(fzf -m --preview="bat --color=always {}")'

# Configuring XDG_CONFIG_HOME for some applications, e.g. k9s
export XDG_CONFIG_HOME="$HOME/.config"

# Enable vi mode
bindkey -v

# Add GOPATH to PATH
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# If on linux, add go to path (on MacOS should be already there if installed via brew)
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  export PATH=$PATH:/usr/local/go/bin
fi

# tmux
if [ -n "$PS1" ] && [ -z "$TMUX" ]; then
  tmux new-session -A -s home -c "$HOME"
fi

# tmux-sesionizer
bindkey -s ^f "tmux-sessionizer\n"
bindkey -s ^j "tmux switch-client -l\n"

# Add .local/scripts to PATH, the catalog contains some custom scripts
export PATH=$PATH:"$HOME/.local/scripts"

alias e="eza -la"
alias b="bat"

# Created by `pipx` on 2025-01-17 16:16:18
export PATH="$PATH:/home/tiberium/.local/bin"
