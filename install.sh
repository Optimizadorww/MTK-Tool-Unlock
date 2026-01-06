#!/data/data/com.termux/files/usr/bin/bash

# Colores
VERDE='\033[1;32m'
CYAN='\033[1;36m'
NC='\033[0m'

clear
echo -e "${VERDE}=========================================="
echo -e "      MTK UNLOCK PRO - FIX TOTAL 2026"
echo -e "==========================================${NC}"

# 1. Limpieza absoluta (Para quitar los errores de tus fotos)
rm -rf $HOME/mtkclient
rm -f $PREFIX/bin/MtkUnlock

# 2. Instalación de paquetes (Sin libcrypt-dev que daba error)
echo -e "\n${CYAN}[1/3] Instalando dependencias básicas...${NC}"
pkg update -y
pkg install python git libusb clang binutils -y

# 3. Descarga forzada del motor (Para evitar el No such file)
echo -e "\n${CYAN}[2/3] Descargando motor de desbloqueo...${NC}"
cd $HOME
git clone --depth 1 https://github.com/bkerler/mtkclient.git
cd mtkclient

# Instalamos las librerías necesarias con el flag que Termux exige
pip install pyusb pyserial --break-system-packages

# 4. Crear el comando con acceso universal
echo -e "\n${CYAN}[3/3] Configurando comando 'MtkUnlock'...${NC}"

cat << 'EOF' > $PREFIX/bin/MtkUnlock
#!/data/data/com.termux/files/usr/bin/bash
clear
echo -e "\033[1;32m=========================================="
echo -e "      MTK BOOTLOADER UNLOCKER 2026"
echo -e "==========================================\033[0m"
echo -e "1. Apaga el celular por completo."
echo -e "2. Conecta presionando Vol+ y Vol-."
echo -e "------------------------------------------"

# Ruta forzada para ejecutar el script real
cd $HOME/mtkclient && python3 mtk oem unlock
EOF

chmod +x $PREFIX/bin/MtkUnlock

echo -e "\n${VERDE}=========================================="
echo -e "        ¡INSTALACIÓN COMPLETADA!"
echo -e "   Escribe 'MtkUnlock' para iniciar"
echo -e "==========================================${NC}"
