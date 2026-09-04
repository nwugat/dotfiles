# Date shortcuts
alias today='date "+%+4Y%+2m%+2d%+2H%+2M%+2S"'
alias todayf='date "+%+4Y%-+2m%-+2d%-+2H%-+2M%+2S"'
alias weeknum='date "+%V"'
alias epoch='date +%s'

# Basic
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias l='eza --icons'
alias ll='eza -lh --icons --group-directories-first'

# File and folder shortcuts
alias cdo='cd ~/notes/'
# alias cdd='cd ~/Downloads/'
alias cdnv='cd ~/.config/nvim/'
alias nvo='nvim +"cd ~/notes/"'
alias nn=nvo
alias notes=nvo

# Clipboard
alias cpe='printf $(date +%s) | wl-copy'
# alias cpts='printf $(date "+%+4Y%+2m%+2d%+2H%+2M%+2S") | wl-copy'
alias cpdk='printf "%s" $(date "+%Y%m%d-%H%M") | wl-copy'
alias clipi='wl-copy'
alias clipo='wl-paste'

# Misc
alias v='nvim'
#alias mc='micro'
# alias open='xdg-open'
alias o='open-from-term'
alias emacs="emacsclient -c -a 'emacs'"
alias r='ranger'
alias ff='fastfetch'
alias fzf0="fzf | tr '\n' '\0'"
alias fzfo="fzf | tr '\n' '\0' | xargs -0 xdg-open"
alias fzfO="fzf | tr '\n' '\0' | xargs -0 xdg-open ; exit"
