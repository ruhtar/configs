export PATH="$PATH:/c/Users/Arthur/dev"


temp() {
	temp=$(curl -s "wttr.in/Aracaju?format=%t")
	echo "Temperatura atual em Aracaju (SE): $temp"
}

function codigo(){
	echo "6c0a734a-da19-4808-9205-8d25d56fb378"
}

load-cfg() {
    home # alias (ajuste se necessário)

    cd ~/dev/configs || return

    # Bash
    cp -v ./terminal/bash/.bash_aliases ~/.bash_aliases
    cp -v ./terminal/bash/.bashrc ~/.bashrc
    cp -v ./terminal/bash/.profile ~/.profile
    cp -v ./terminal/bash/.bash_profile ~/.bash_profile

    # Yasb (descomentando caso vá usar)
    # cp -v ./.config/yasb/config.yaml ~/.config/yasb/config.yaml
    # cp -v ./.config/yasb/styles.css ~/.config/yasb/styles.css

    # Fastfetch (descomentando caso vá usar)
    # cp -v ./terminal/fastfetch/config.jsonc ~/.config/fastfetch/config.jsonc

    # Yazi (Windows, adapte para Linux se necessário)
    # cp -v ./.config/yazi/keymap.toml ~/AppData/Roaming/yazi/config/keymap.toml
    # cp -v ./.config/yazi/theme.toml ~/AppData/Roaming/yazi/config/theme.toml

    echo "Configurações carregadas do repositório para o sistema local."
}


upd-cfg(){
	home #alias
	cd dev/configs || return
	cp -v ~/.bash_aliases ~/.bashrc ~/.profile ~/.bash_profile ./terminal/bash
	#cp -v C:/Users/Arthur/.config/yasb/config.yaml C:/Users/Arthur/.config/yasb/styles.css  ./.config/yasb
	#cp -v ~/.config/fastfetch/config.jsonc ./terminal/fastfetch
	#cp -v C:/Users/Arthur/AppData/Roaming/yazi/config/keymap.toml C:/Users/Arthur/AppData/Roaming/yazi/config/theme.toml C:/Users/Arthur/AppData/Roaming/yazi/config/yazi.toml  ./.config/yasi  
	git add .
	git commit -m "updating all dotfiles config files"
	git push
	echo "Configurações atualizadas no repositório remoto."
}


# Abre o repositório atual do GitHub no navegador
github() {
  if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    echo "❌ Este diretório não é um repositório Git."
    return 1
  fi

  remote_url=$(git config --get remote.origin.url)
  if [ -z "$remote_url" ]; then
    echo "❌ Nenhuma URL remota 'origin' encontrada."
    return 1
  fi

  # Extrai a URL sem credenciais e converte para o formato web do GitHub
  if [[ "$remote_url" =~ ^https://([^@]+)@github\.com/(.*)(\.git)?$ ]]; then
    repo_path="${BASH_REMATCH[2]}"
  elif [[ "$remote_url" =~ ^git@github\.com:(.*)(\.git)?$ ]]; then
    repo_path="${BASH_REMATCH[1]}"
  elif [[ "$remote_url" =~ ^https://github\.com/(.*)(\.git)?$ ]]; then
    repo_path="${BASH_REMATCH[1]}"
  else
    echo "❌ Formato de URL remoto não suportado: $remote_url"
    return 1
  fi

  web_url="https://github.com/$repo_path"
  echo "🌐 Abrindo $web_url ..."

  # Detecta ambiente (WSL, Linux, Mac, Windows)
  # Detecta o ambiente de execução e abre a URL no navegador apropriado
  if grep -qEi "(Microsoft|WSL)" /proc/version &> /dev/null; then
    # Ambiente WSL (Windows Subsystem for Linux) — usa o Explorer do Windows
    explorer.exe "$web_url"
  elif command -v xdg-open > /dev/null; then
    # Ambiente Linux padrão — usa o xdg-open (abridor de links genérico no Linux)
    xdg-open "$web_url"
  elif command -v open > /dev/null; then
    # Ambiente macOS — usa o comando open
    open "$web_url"
  elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" ]]; then
    # Git Bash ou Cygwin no Windows — usa start do CMD
    start "" "$web_url"
  else
    # Ambiente desconhecido — falha com mensagem clara
    echo "❌ Não foi possível abrir o navegador automaticamente."
    return 1
  fi
}

if [ -f ~/.bash_aliases ]; then
  source ~/.bash_aliases
fi

#fastfetch --logo Linux_small

#eval "$(fzf --bash)"

eval "$(zoxide init bash)"

# Atalho para abrir projeto .NET no Rider
rider() {
    "/c/Program Files/JetBrains/JetBrains Rider 2025.1.4/bin/rider64.exe" "$(pwd)" &
}
