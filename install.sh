#!/data/data/com.termux/files/usr/bin/bash

# Colores
VERDE='\033[1;32m'
CYAN='\033[1;36m'
ROJO='\033[1;31m'
NC='\033[0m'

clear
echo -e "${VERDE}=========================================="
echo -e "      MTK UNLOCK PRO - MODO MANUAL"
echo -e "==========================================${NC}"

# 1. Limpieza total de intentos fallidos
rm -rf $HOME/mtkclient
rm -f $PREFIX/bin/MtkUnlock

# 2. Instalación de paquetes base (Lo que sí funcionó en tus fotos)
echo -e "\n${CYAN}[1/3] Preparando sistema...${NC}"
pkg update -y
pkg install python git libusb clang binutils -y

# 3. Descarga Manual (Esto evita el error de PIP de tus capturas)
echo -e "\n${CYAN}[2/3] Descargando motor de desbloqueo...${NC}"
cd $HOME
# Forzamos la descarga del repositorio completo
git clone --depth 1 https://github.com/bkerler/mtkclient.git

# 4. Instalación de librerías USB
echo -e "\n${CYAN}[3/3] Instalando librerías críticas...${NC}"
# Usamos el flag que pide Termux en tus fotos
pip install pyusb pyserial --break-system-packages

# 5. Configurar el acceso directo con RUTA ABSOLUTA
cat << 'EOF' > $PREFIX/bin/MtkUnlock
#!/data/data/com.termux/files/usr/bin/bash
clear
echo -e "\033[1;32m=========================================="
echo -e "      XIAOMI/MTK BOOTLOADER UNLOCKER"
echo -e "==========================================\033[0m"

# Entramos a la carpeta para que NO salga "No such file"
if [ -d "$HOME/mtkclient" ]; then
    cd $HOME/mtkclient
    # Ejecutamos el archivo directamente con Python3
    python3 mtk oem unlock
else
    echo -e "\033[1;31mERROR: La carpeta no existe. Reintenta la instalación.\033[0m"
fi
EOF

chmod +x $PREFIX/bin/MtkUnlock

echo -e "\n${VERDE}=========================================="
echo -e "        ¡POR FIN INSTALADO!"
echo -e "   Escribe 'MtkUnlock' para iniciar"
echo -e "==========================================${NC}"
