

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
  if [[ "$remote_url" =~ ^https://([^@]+)@github\.com/(.*)\.git$ ]]; then
    repo_path="${BASH_REMATCH[2]}"
  elif [[ "$remote_url" =~ ^git@github\.com:(.*)\.git$ ]]; then
    repo_path="${BASH_REMATCH[1]}"
  elif [[ "$remote_url" =~ ^https://github\.com/(.*)\.git$ ]]; then
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


# Abre o repositório atual do github 
# github() {
#   if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
#     echo "Este diretório não é um repositório Git."
#     return 1
#   fi

#   remote_url=$(git config --get remote.origin.url)

#   if [ -z "$remote_url" ]; then
#     echo "Nenhuma URL remota 'origin' encontrada."
#     return 1
#   fi

#   # Remove token e converte para URL web padrão
#   if [[ "$remote_url" =~ https://([^@]+)@github\.com/(.*)\.git ]]; then
#     repo_path="${BASH_REMATCH[2]}"
#     web_url="https://github.com/$repo_path"
#   elif [[ "$remote_url" =~ git@github\.com:(.*)\.git ]]; then
#     repo_path="${BASH_REMATCH[1]}"
#     web_url="https://github.com/$repo_path"
#   elif [[ "$remote_url" =~ https://github\.com/(.*)\.git ]]; then
#     repo_path="${BASH_REMATCH[1]}"
#     web_url="https://github.com/$repo_path"
#   else
#     echo "Formato de URL remoto não suportado: $remote_url"
#     return 1
#   fi

#   echo "Abrindo $web_url ..."
#   if [[ "$OSTYPE" == "msys"* || "$OSTYPE" == "cygwin"* ]]; then
#     start "" "$web_url"
#   elif command -v xdg-open > /dev/null; then
#     xdg-open "$web_url"
#   elif command -v open > /dev/null; then
#     open "$web_url"
#   else
#     echo "Não foi possível abrir o navegador."
#     return 1
#   fi
# }

if [ -f ~/.bash_aliases ]; then
  source ~/.bash_aliases
fi

eval "$(zoxide init bash)"
