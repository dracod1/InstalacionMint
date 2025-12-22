#!/bin/bash
# Script completo: Nala + Brave + Tailscale + zoxide para Linux Mint


###################
## PARA INSTALAR EN LA CONSOLA: 
#curl -fsSL https://raw.githubusercontent.com/tuusuario/linux-mint-setup/main/install.sh -o install.sh 
#chmod +x install.sh && ./install.sh
##################################################################
echo "🔄 Actualizando sistema con apt..."
sudo apt update && sudo apt upgrade -y

echo "⚡ Instalando Nala (descargas paralelas)..."
sudo apt install nala -y

echo "🌐 Instalando Brave (descargas paralelas con Nala)..."
curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
nala update
nala install brave-browser -y

# Configurar Brave como default
xdg-settings set default-web-browser brave-browser.desktop

echo "🔒 Instalando Tailscale..."
curl -fsSL https://tailscale.com/install.sh | sh

echo "🚀 Instalando zoxide (navegación inteligente)..."
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
echo 'export PATH=$HOME/.local/bin:$PATH' >> ~/.bashrc
source ~/.bashrc

echo "✅ ¡Instalación completa!"
echo "💡 Usa: z (en vez de cd) | sudo tailscale up | brave-browser"
echo "🔍 Verifica: zoxide version"
