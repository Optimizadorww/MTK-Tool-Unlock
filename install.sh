#!/data/data/com.termux/files/usr/bin/bash

# Colores
VERDE='\033[1;32m'
CYAN='\033[1;36m'
NC='\033[0m'

clear
echo -e "${VERDE}=========================================="
echo -e "      MTK UNLOCK PRO v9.0 - FORZADO"
echo -e "==========================================${NC}"

# 1. Instalación de lo básico (Sin libcrypt-dev)
echo -e "\n${CYAN}[1/2] Preparando entorno de sistema...${NC}"
pkg update -y
pkg install python libusb git clang binutils -y

# 2. Descarga forzada del motor (Ignorando errores de PIP)
echo -e "\n${CYAN}[2/2] Descargando motor de desbloqueo...${NC}"
cd $HOME
rm -rf mtkclient
git clone --depth 1 https://github.com/bkerler/mtkclient.git
cd mtkclient
# Instalamos solo las dependencias mínimas para que no de error de bloqueado
pip install pyusb pyserial --break-system-packages

# 3. Crear el acceso directo con RUTA ABSOLUTA AUTOMÁTICA
echo -e "\n${CYAN}[+] Configurando comando 'MtkUnlock'...${NC}"

# Buscamos donde quedó mtk para que no te salga "No such file"
cat << EOF > $PREFIX/bin/MtkUnlock
#!/data/data/com.termux/files/usr/bin/bash
clear
echo -e "\033[1;32m=========================================="
echo -e "      XIAOMI/MTK BOOTLOADER UNLOCKER"
echo -e "==========================================\033[0m"
echo -e "1. Apaga el celular por completo."
echo -e "2. Mantén Vol+ y Vol- conectados."
echo -e "3. Conecta el cable USB ahora."
echo -e "------------------------------------------"

# Ejecución forzada desde la carpeta de usuario
python3 \$HOME/mtkclient/mtk oem unlock
EOF

chmod +x $PREFIX/bin/MtkUnlock

echo -e "\n${VERDE}=========================================="
echo -e "        ¡INSTALACIÓN FORZADA LISTA!"
echo -e "   Escribe 'MtkUnlock' para empezar"
echo -e "==========================================${NC}"
