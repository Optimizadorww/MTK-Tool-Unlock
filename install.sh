#!/data/data/com.termux/files/usr/bin/bash

# Colores
VERDE='\033[1;32m'
CYAN='\033[1;36m'
NC='\033[0m'

clear
echo -e "${VERDE}=========================================="
echo -e "      MTK UNLOCK PRO v5.0 - SOLUCIÓN REAL"
echo -e "==========================================${NC}"

# 1. Instalar solo paquetes básicos que Termux SI permite
echo -e "\n${CYAN}[1/2] Instalando dependencias de sistema...${NC}"
pkg update -y
pkg install python libusb clang git binutils -y

# 2. Descargar mtkclient directamente (Sin usar PIP para la instalación)
echo -e "\n${CYAN}[2/2] Clonando motor de desbloqueo desde GitHub...${NC}"
cd $HOME
rm -rf mtkclient # Borramos instalaciones viejas que fallaron
git clone https://github.com/bkerler/mtkclient.git

# Instalar las únicas 2 librerías necesarias saltando el bloqueo de Termux
pip install pyusb pyserial --break-system-packages

# 3. Crear el acceso directo indestructible
echo -e "\n${CYAN}[+] Configurando comando 'MtkUnlock'...${NC}"

cat << 'EOF' > $PREFIX/bin/MtkUnlock
#!/data/data/com.termux/files/usr/bin/bash
# Interfaz de usuario
VERDE='\033[1;32m'
CYAN='\033[1;36m'
NC='\033[0m'

while true; do
    clear
    echo -e "${VERDE}=============================================================="
    echo -e "            MTK BOOTLOADER UNLOCKER - MODO DIRECTO"
    echo -e "==============================================================${NC}"
    echo -e " 1) DESBLOQUEAR BOOTLOADER (Unlock)"
    echo -e " 2) BLOQUEAR BOOTLOADER (Lock)"
    echo -e " 3) SALIR"
    echo ""
    read -p " SELECCIONA: " opt
    case $opt in
        1)
            echo -e "\n[!] Conecta el equipo apagado (Vol+ y Vol-)..."
            # Ejecutamos el script descargado directamente
            python3 $HOME/mtkclient/mtk oem unlock
            read -p "Presiona Enter para volver..." ;;
        2)
            python3 $HOME/mtkclient/mtk oem lock
            read -p "Presiona Enter para volver..." ;;
        3) exit 0 ;;
    esac
done
EOF

chmod +x $PREFIX/bin/MtkUnlock

echo -e "\n${VERDE}=========================================="
echo -e "        ¡INSTALACIÓN EXITOSA!"
echo -e "   Escribe 'MtkUnlock' para empezar"
echo -e "==========================================${NC}"
