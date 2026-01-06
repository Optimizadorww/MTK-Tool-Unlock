#!/data/data/com.termux/files/usr/bin/bash

# Colores
VERDE='\033[1;32m'
CYAN='\033[1;36m'
NC='\033[0m'

clear
echo -e "${VERDE}=========================================="
echo -e "      MTK UNLOCK PRO - SOLUCIÓN FINAL 2026"
echo -e "==========================================${NC}"

# 1. Limpieza total de errores previos
rm -rf $HOME/mtkclient
rm -f $PREFIX/bin/MtkUnlock

# 2. Instalación de paquetes básicos (Lo que sí funciona)
echo -e "\n${CYAN}[1/2] Instalando entorno de sistema...${NC}"
pkg update -y
pkg install python git libusb clang binutils -y

# 3. Descarga directa del motor (Soluciona el error de carpeta no encontrada)
echo -e "\n${CYAN}[2/2] Descargando motor de desbloqueo...${NC}"
cd $HOME
git clone --depth 1 https://github.com/bkerler/mtkclient.git
cd mtkclient

# Instalamos las librerías USB necesarias saltando el bloqueo de Termux
pip install pyusb pyserial --break-system-packages

# 4. Crear el comando con RUTA ABSOLUTA
echo -e "\n${CYAN}[+] Configurando comando 'MtkUnlock'...${NC}"

cat << EOF > $PREFIX/bin/MtkUnlock
#!/data/data/com.termux/files/usr/bin/bash
clear
echo -e "\033[1;32m=========================================="
echo -e "      XIAOMI/MTK BOOTLOADER UNLOCKER"
echo -e "==========================================\033[0m"
echo -e "1. Celular APAGADO."
echo -e "2. Conecta con Vol+ y Vol- presionados."
echo -e "------------------------------------------"

# Esta ruta fuerza a Python a encontrar el archivo mtk
python3 \$HOME/mtkclient/mtk oem unlock
EOF

chmod +x $PREFIX/bin/MtkUnlock

echo -e "\n${VERDE}=========================================="
echo -e "        ¡INSTALACIÓN COMPLETADA!"
echo -e "   Escribe 'MtkUnlock' para iniciar"
echo -e "==========================================${NC}"
