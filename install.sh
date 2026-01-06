#!/data/data/com.termux/files/usr/bin/bash

# Colores
VERDE='\033[1;32m'
CYAN='\033[1;36m'
NC='\033[0m'

clear
echo -e "${VERDE}=========================================="
echo -e "      MTK UNLOCK PRO - FIX DEFINITIVO"
echo -e "==========================================${NC}"

# 1. Limpiar basura de intentos anteriores (IMPORTANTE)
rm -rf $HOME/mtkclient
rm -f $PREFIX/bin/MtkUnlock

# 2. Instalar dependencias base
echo -e "\n${CYAN}[1/2] Instalando dependencias de sistema...${NC}"
pkg update -y
pkg install python git libusb clang binutils -y

# 3. Descargar motor directamente y forzar librerías
echo -e "\n${CYAN}[2/2] Descargando motor de desbloqueo...${NC}"
cd $HOME
git clone --depth 1 https://github.com/bkerler/mtkclient.git
cd mtkclient
pip install pyusb pyserial --break-system-packages

# 4. Crear el comando ejecutable con ruta fija
echo -e "\n${CYAN}[+] Configurando comando 'MtkUnlock'...${NC}"

cat << EOF > $PREFIX/bin/MtkUnlock
#!/data/data/com.termux/files/usr/bin/bash
clear
echo -e "\033[1;32m=========================================="
echo -e "      MTK BOOTLOADER UNLOCKER 2026"
echo -e "==========================================\033[0m"
echo -e "1. Apaga el celular por completo."
echo -e "2. Conecta con Vol+ y Vol- presionados."
echo -e "------------------------------------------"

# Forzamos la entrada a la carpeta antes de ejecutar
cd \$HOME/mtkclient
python3 mtk oem unlock
EOF

chmod +x $PREFIX/bin/MtkUnlock

echo -e "\n${VERDE}=========================================="
echo -e "        ¡INSTALACIÓN COMPLETADA!"
echo -e "   Escribe 'MtkUnlock' para iniciar"
echo -e "==========================================${NC}"
