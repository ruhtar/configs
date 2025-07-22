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


# Se não for Linux, tenta instalar via winget
if [[ "$OS" != "Linux" ]]; then
    echo "🔍 Verificando disponibilidade do winget..."
    if ! command -v winget &> /dev/null; then
        echo "❌ winget não está instalado. Instale o App Installer pela Microsoft Store e tente novamente."
        exit 1
    fi

    echo "✅ winget encontrado!"
    echo "📦 Iniciando instalação dos pacotes com winget..."

    packages=(
        "ajeetdsouza.zoxide" 
        "sharkdp.bat"
        "eza-community.eza"
    )

    for pkg in "${packages[@]}"; do
        echo "📦 Instalando $pkg..."
        winget install --id "$pkg" --silent --accept-package-agreements --accept-source-agreements \
            && echo "✅ $pkg instalado com sucesso!" \
            || echo "❌ Falha ao instalar $pkg"
    done
    echo ""
else
    echo "🔎 Detectando distribuição Linux para instalação de pacotes..."

    if [ -f /etc/os-release ]; then
        . /etc/os-release
        DISTRO=$ID
        echo "📛 Distribuição: $DISTRO"

        if [[ "$DISTRO" == "ubuntu" || "$DISTRO" == "debian" ]]; then
            echo "📦 Instalando pacotes via apt..."

            sudo apt update
            sudo apt install -y zoxide bat eza \
                && echo "✅ Pacotes instalados com sucesso!" \
                || echo "❌ Falha ao instalar pacotes via apt."
        else
            echo "⚠️  Distribuição Linux não suportada automaticamente. Instale os pacotes manualmente:"
            echo "    sudo apt install zoxide bat eza"
        fi
    else
        echo "⚠️  Não foi possível identificar a distribuição. Instale manualmente: zoxide, bat, eza."
    fi
fi


# Instala o micro (cross-platform)
cd "$DEST_DIR"
echo "📥 Baixando e instalando o editor micro..."
curl -s https://getmic.ro | bash && echo "✅ micro instalado!" || echo "❌ Falha ao instalar o micro."
echo ""


echo "🎉 Instalação e configuração finalizadas com sucesso!"
