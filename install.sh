#!/bin/bash
# Script completo: Nala + Brave + Vivaldi + Tailscale + zoxide para Linux Mint


###################
## PARA INSTALAR EN LA CONSOLA: 
#curl -fsSL https://raw.githubusercontent.com/dracod1/InstalacionMint/refs/heads/main/install.sh -o install.sh 
#chmod +x install.sh && ./install.sh
#sudo tailscale up  # Solo para autenticar Tailscale
##################################################################

echo "🇪🇸 Configurando teclado español, se borra al reinicio..."
setxkbmap -layout es -option grp:alt_shift_toggle

echo "🔄 Actualizando sistema con apt..."
sudo apt update && sudo apt upgrade -y

echo "⚡ Instalando Nala (descargas paralelas)..."
sudo apt install -y nala curl gnupg ca-certificates

echo "🌐 Repositorio Brave..."
curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list

echo "🌐 Repositorio Vivaldi..."
curl -fsSL https://repo.vivaldi.com/stable/linux_signing_key.pub \
  | sudo gpg --dearmor -o /usr/share/keyrings/vivaldi.gpg

cat <<EOF | sudo tee /etc/apt/sources.list.d/vivaldi.sources > /dev/null
Types: deb
URIs: https://repo.vivaldi.com/stable/deb/
Suites: stable
Components: main
Architectures: amd64
Signed-By: /usr/share/keyrings/vivaldi.gpg
EOF

echo "⚡ Actualizando índices y instalando TODO de golpe con Nala..."
sudo nala update
sudo nala install -y brave-browser vivaldi-stable

# Configurar Brave como default
xdg-settings set default-web-browser brave-browser.desktop

echo "🔒 Instalando Tailscale..."
curl -fsSL https://tailscale.com/install.sh | sh

echo "🚀 Instalando zoxide..."
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

# PATH inmediato + persistente
echo 'export PATH=$HOME/.local/bin:$PATH' >> ~/.bashrc
export PATH="$HOME/.local/bin:$PATH"

# Test inmediato
if command -v zoxide >/dev/null 2>&1; then
    echo "✅ zoxide v$(zoxide --version) instalado correctamente"
    echo "💡 Prueba: z Documents (aprende tus directorios)"
else
    echo "❌ Error zoxide, reinicia terminal"
fi

