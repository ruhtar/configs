#!/bin/bash

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
