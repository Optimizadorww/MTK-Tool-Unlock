#!/data/data/com.termux/files/usr/bin/bash

# Colores
VERDE='\033[1;32m'
CYAN='\033[1;36m'
NC='\033[0m'

clear
echo -e "${VERDE}=========================================="
echo -e "      MTK UNLOCK PRO - SOLUCIÓN REAL"
echo -e "==========================================${NC}"

# 1. Limpieza absoluta de intentos fallidos
rm -rf $HOME/mtkclient
rm -f $PREFIX/bin/MtkUnlock

# 2. Instalación de lo que sí funciona (Base)
echo -e "\n${CYAN}[1/3] Instalando dependencias de sistema...${NC}"
pkg update -y
pkg install python git libusb clang binutils -y

# 3. Descarga Directa (Bypass de PIP)
echo -e "\n${CYAN}[2/3] Descargando motor de desbloqueo...${NC}"
cd $HOME
git clone --depth 1 https://github.com/bkerler/mtkclient.git

# Instalación manual de librerías para evitar el error de Termux
pip install pyusb pyserial --break-system-packages

# 4. Creación del comando con RUTA FIJA
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

# Forzamos la ejecución desde la carpeta que acabamos de clonar
cd $HOME/mtkclient && python3 mtk oem unlock
EOF

chmod +x $PREFIX/bin/MtkUnlock

echo -e "\n${VERDE}=========================================="
echo -e "        ¡INSTALACIÓN COMPLETADA!"
echo -e "   Escribe 'MtkUnlock' para iniciar"
echo -e "==========================================${NC}"
