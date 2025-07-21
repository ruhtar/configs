#!/bin/bash

echo "🔍 Detectando sistema operacional..."
OS="$(uname -s)"
echo "🖥️  Sistema detectado: $OS"

# Define o diretório de destino dependendo do SO
if [[ "$OS" == "Linux" ]]; then
    DEST_DIR="$HOME"
    echo "📂 Diretório de destino definido como: $DEST_DIR (Linux)"
else
    USER_WIN="$(whoami | awk -F'\\\\' '{print $NF}')"
    DEST_DIR="/c/Users/$USER_WIN"
    echo "📂 Diretório de destino definido como: $DEST_DIR (Windows)"
fi

# Diretório de origem
SOURCE_DIR="./terminal/bash"
echo "📦 Diretório de origem: $SOURCE_DIR"

# Lista de arquivos a copiar
FILES=(
    ".bashrc"
    ".bash_aliases"
    ".profile"
)

echo "📁 Iniciando cópia dos arquivos de configuração do bash..."

# Faz a cópia de cada arquivo
for file in "${FILES[@]}"; do
    echo "➡️  Verificando $file..."
    if [ -f "$SOURCE_DIR/$file" ]; then
        echo "✅ Copiando $file para $DEST_DIR"
        cp "$SOURCE_DIR/$file" "$DEST_DIR/"
    else
        echo "⚠️  Arquivo $file não encontrado em $SOURCE_DIR"
    fi
done

echo "✅ Arquivos de configuração copiados com sucesso!"
echo ""

# Instala o micro (cross-platform)
echo "📥 Baixando e instalando o editor micro..."
curl -s https://getmic.ro | bash && echo "✅ micro instalado!" || echo "❌ Falha ao instalar o micro."
echo ""

# Se não for Linux, tenta instalar via winget
if [[ "$OS" != "Linux" ]]; then
    echo "🔍 Verificando disponibilidade do winget..."
    if ! command -v winget &> /dev/nu
