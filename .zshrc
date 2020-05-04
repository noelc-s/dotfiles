# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
  export ZSH=/home/noel/.oh-my-zsh

# export PATH=$PATH:~/apps/nwcap

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"


# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)


# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
export EDITOR=nvim
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# (wal -r -t &)

function prompt_char {
	if [ $UID -eq 0 ]; then echo "#"; else echo $; fi
}

# PROMPT='%{$fg_bold[red]%}%m %{$reset_color%}%{$fg[yellow]%}%(4~|%-1~/…/%2~|%4~) $(git_prompt_info)%_$(prompt_char)%{$reset_color%} '

PROMPT="%K{black}%F{white} %F{cyan}%f %m %K{blue}%F{black}"$'\ue0b0'"%k"
PROMPT+="%K{blue}%F{white} %(4~|%-1~/…/%2~|%4~) %k%F{blue}"$'\ue0b0'"%k"
PROMPT+="%F{blue} $ %k%f"

RPROMPT='%F{yellow}'$'\ue0b2''%K{yellow}%F{black}  $(git_prompt_info)%k%f'

ZSH_THEME_GIT_PROMPT_PREFIX="("
ZSH_THEME_GIT_PROMPT_SUFFIX=") "

source $ZSH/oh-my-zsh.sh

alias ls="colorls -a --sd"
alias l="colorls -la --sd"
alias mat="i3-msg workspace 8 && matlab &"
alias spot="i3-msg workspace 9 && spotify &"

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi

# eval $(thefuck --alias)
export SF_POST_DATA="/files/Dropbox (GaTech)/Dropbox (GaTech)/SIMULTANEOUSMOTIONS/Synergies"
export DB_TOKEN="44uwL-AAgXAAAAAAAAAFP-y7D1mMICrW52N-8HaNBqnRGNZ3nIPPGghYI0fiV6Sq"


function dropbox_ok {
	if [ ! -d "/files" ]; then
		echo "you may not start dropbox. /files is not mounted."
	else
		dropbox "$@"
	fi
}
alias dropbox=dropbox_ok
alias epic="cd /files/src/sf_post"
alias cine="cd /files/src/cinelimb"
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

alias a='fasd -a'        # any
alias s='fasd -si'       # show / search / select
alias d='fasd -d'        # directory
alias f='fasd -f'        # file
alias sd='fasd -sid'     # interactive directory selection
alias sf='fasd -sif'     # interactive file selection
alias z='fasd_cd -d'     # cd, same functionality as j in autojump
alias zz='fasd_cd -d -i' # cd with interactive selection
alias v='f -e vim' # quick opening files with vim

LD_LIBRARY_PATH=/usr/local/Wolfram/Mathematica/12.0/SystemFiles/Links/MathLink/DeveloperKit/Linux-x86-64/CompilerAdditions:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH

alias n='nvim'
eval "$(fasd --init auto)"
alias config='/usr/bin/git --git-dir=/home/noel/.myconfig/ --work-tree=/home/noel'

export PATH=${PATH}:~/android-sdk-linux/platform-tools

export matlabroot='/usr/local/MATLAB/R2018a'
source /opt/ros/melodic/setup.zsh

export LOCAL_BUILD=/usr/local/raisim_build
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$LOCAL_BUILD/lib
