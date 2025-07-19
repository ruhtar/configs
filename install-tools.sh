#!/bin/bash

# Diretório de origem (relativo ou absoluto)
SOURCE_DIR="./terminal/bash"

# Diretório de destino (seu home no Windows)
DEST_DIR="/c/Users/Arthur"

# Lista de arquivos a copiar
FILES=(
    ".bashrc"
    ".bash_aliases"
    ".profile"
)

# Faz a cópia de cada arquivo
for file in "${FILES[@]}"; do
    if [ -f "$SOURCE_DIR/$file" ]; then
        echo "📁 Copiando $file para $DEST_DIR"
        cp "$SOURCE_DIR/$file" "$DEST_DIR/"
    else
        echo "⚠️  Arquivo $file não encontrado em $SOURCE_DIR"
    fi
done

echo "✅ Configurações do bash copiadas com sucesso!"

# Instalar o micro
curl https://getmic.ro | bash 


# Verifica se o winget está disponível
if ! command -v winget &> /dev/null; then
    echo "❌ winget não está instalado. Instale o App Installer pela Microsoft Store e tente novamente."
    exit 1
fi

echo "✅ winget encontrado!"

# Lista de pacotes a instalar
packages=(
    "ajeetdsouza.zoxide" 
    "sharkdp.bat"
    "eza-community.eza"
)

# Instala cada pacote
for pkg in "${packages[@]}"; do
    echo "📦 Instalando $pkg..."
    winget install --id "$pkg" --silent --accept-package-agreements --accept-source-agreements
done

echo "🎉 Instalação concluída!"
