#!/data/data/com.termux/files/usr/bin/bash

# Colores
VERDE='\033[1;32m'
CYAN='\033[1;36m'
NC='\033[0m'

clear
echo -e "${VERDE}=========================================="
echo -e "      MTK UNLOCK PRO - MODO NO-ROOT"
echo -e "==========================================${NC}"

# 1. Instalación de paquetes básicos permitidos
echo -e "\n${CYAN}[1/2] Preparando entorno...${NC}"
pkg update -y
pkg install python git libusb clang binutils -y

# 2. Instalación de librerías saltando el bloqueo de PIP (Foto 1000053736)
# Usamos el flag obligatorio para Android sin Root
echo -e "\n${CYAN}[2/2] Instalando librerías USB...${NC}"
pip install pyusb pyserial --break-system-packages

# 3. Descarga directa en el HOME del usuario (Sin Root)
cd $HOME
rm -rf mtkclient
echo -e "\n${CYAN}[+] Descargando archivos necesarios...${NC}"
git clone --depth 1 https://github.com/bkerler/mtkclient.git

# 4. Crear el comando ejecutable
cat << 'EOF' > $PREFIX/bin/MtkUnlock
#!/data/data/com.termux/files/usr/bin/bash
clear
echo -e "\033[1;32m=========================================="
echo -e "      MTK BOOTLOADER UNLOCKER (SIN ROOT)"
echo -e "==========================================\033[0m"
echo -e "1. Apaga el celular."
echo -e "2. Conecta con Vol+ y Vol- presionados."
echo -e "------------------------------------------"

# Ruta local garantizada
cd $HOME/mtkclient
python3 mtk oem unlock
EOF

chmod +x $PREFIX/bin/MtkUnlock

echo -e "\n${VERDE}=========================================="
echo -e "        INSTALACIÓN TERMINADA"
echo -e "   Escribe 'MtkUnlock' para iniciar"
echo -e "==========================================${NC}"
