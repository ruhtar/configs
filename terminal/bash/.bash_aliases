alias rld="source ~/.bashrc"

alias cat="bat"
alias ll='ls -l'
alias la='ls -Al'
alias lt='ls -ltrh'
alias bashrc="micro ~/.bashrc"
alias aliases="micro ~/.bash_aliases"

# Alias dinâmico para o diretório home do usuário, compatível com Linux e Windows
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    alias home='cd ~'
elif [[ "$OSTYPE" == "msys"* || "$OSTYPE" == "win32" ]]; then
    USER_WIN="$(whoami | awk -F'\\\\' '{print $NF}')"
    alias home="cd /c/Users/$USER_WIN"
fi

alias ls='eza -la --group-directories-first'

alias explorer="explorer ."
alias exp="explorer ."
alias yasb="z ~/.config/yasb"

# Alias para o editor Micro compatível com Linux e Windows
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    alias micro='~/micro'
    alias bat="batcat"
elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "win32" ]]; then
    alias micro='/c/Users/Arthur/dev/micro.exe'
fi

