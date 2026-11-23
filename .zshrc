# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

#environment vars

GTK_IM_MODULE=fcitx
QT_IM_MODULE=fcitx
XMODIFIERS=@im=fcitx
SDL_IM_MODULE=fcitx
GLFW_IM_MODULE=fcitx

QT_QPA_PLATFORMTHEME=qtk3
QT_QPA_PLATFORM=wayland

# Gpu stuff
export LIBVA_DRIVER_NAME=iHD


#defaults 

export EDITOR=nvim

# alywas run obs with prime-run to use the gpu
alias obs='prime-run obs'

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="Ultima Theme"

#oh my zsh plugins

# Modern Dark Pro Capsule Theme Config
ZSH_THEME="agnoster"


plugins=(git archlinux zsh-autosuggestions zsh-syntax-highlighting zoxide)

source $ZSH/oh-my-zsh.sh

#aliases 

alias ll='lsd -l'
alias ls='lsd'
alias lh='lsd -lah'
alias ytsong='yt-dlp -i -x -f ba --embed-thumbnail --add-metadata'



# fnm
FNM_PATH="/home/maru/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "$(fnm env --shell zsh)"
fi


# Added by Antigravity CLI installer
export PATH="/home/maru/.local/bin:$PATH"
export PATH="/home/maru/.local/bin:$PATH"

# eval "$(starship init zsh)"
