#!/data/data/com.termux/files/usr/bin/bash

# Colores
VERDE='\033[1;32m'
CYAN='\033[1;36m'
NC='\033[0m'

clear
echo -e "${VERDE}=========================================="
echo -e "      MTK UNLOCK PRO - FIX SIN-ROOT"
echo -e "==========================================${NC}"

# 1. Limpieza total de lo que no sirve (Tus fotos 1000053741/43)
rm -rf $HOME/mtkclient
rm -f $PREFIX/bin/MtkUnlock

# 2. Instalación de paquetes base
echo -e "\n${CYAN}[1/2] Instalando paquetes...${NC}"
pkg update -y
pkg install python git libusb clang binutils wget -y

# 3. Descarga Manual y Forzada
echo -e "\n${CYAN}[2/2] Descargando motor de desbloqueo...${NC}"
cd $HOME
# Descargamos el motor directamente sin pedir permiso a git si falla
git clone --depth 1 https://github.com/bkerler/mtkclient.git || (wget https://github.com/bkerler/mtkclient/archive/refs/heads/main.zip && unzip main.zip && mv mtkclient-main mtkclient)

# Instalamos las librerías con el flag que te pide tu Termux (Foto 1000053736)
pip install pyusb pyserial --break-system-packages

# 4. Crear acceso directo con RUTA ABSOLUTA FORZADA
echo -e "\n${CYAN}[+] Configurando acceso directo...${NC}"

cat << 'EOF' > $PREFIX/bin/MtkUnlock
#!/data/data/com.termux/files/usr/bin/bash
clear
echo -e "\033[1;32m=========================================="
echo -e "      MTK UNLOCKER - MODO SEGURO"
echo -e "==========================================\033[0m"
echo -e "1. Apaga el cel."
echo -e "2. Mantén Vol+ y Vol-."
echo -e "3. Conecta el USB."
echo -e "------------------------------------------"

# Intentamos ejecutar el archivo físico directamente para evitar el "No such file"
if [ -d "$HOME/mtkclient" ]; then
    python3 $HOME/mtkclient/mtk oem unlock
else
    echo -e "\033[1;31mERROR: La carpeta no existe. Reintenta la instalación.\033[0m"
fi
EOF

chmod +x $PREFIX/bin/MtkUnlock

echo -e "\n${VERDE}=========================================="
echo -e "        LISTO - SIN ERRORES"
echo -e "   Escribe 'MtkUnlock' para iniciar"
echo -e "==========================================${NC}"
