#!/data/data/com.termux/files/usr/bin/bash

# Colores estilo Hacker
VERDE='\033[1;32m'
CYAN='\033[1;36m'
ROJO='\033[1;31m'
NC='\033[0m'

clear
echo -e "${VERDE}=========================================="
echo -e "      MTK UNLOCK PRO v6.0 - FIX TOTAL"
echo -e "==========================================${NC}"

# 1. Limpieza absoluta de intentos fallidos
echo -e "\n${CYAN}[1/3] Limpiando residuos anteriores...${NC}"
rm -rf $HOME/mtkclient
rm -f $PREFIX/bin/MtkUnlock

# 2. Instalación de dependencias de sistema (Lo que SI funciona)
echo -e "\n${CYAN}[2/3] Instalando dependencias básicas...${NC}"
pkg update -y
pkg install python libusb clang git binutils make -y

# 3. Descarga Directa y Configuración Manual
echo -e "\n${CYAN}[3/3] Descargando motor mtkclient desde origen...${NC}"
cd $HOME
git clone https://github.com/bkerler/mtkclient.git
cd mtkclient

# Instalamos las librerías necesarias ignorando las advertencias de Termux
pip install pyusb pyserial --break-system-packages

# 4. Crear el comando ejecutable indestructible
echo -e "\n${CYAN}[+] Configurando acceso directo...${NC}"

cat << 'EOF' > $PREFIX/bin/MtkUnlock
#!/data/data/com.termux/files/usr/bin/bash
# Interfaz de usuario mejorada
VERDE='\033[1;32m'
CYAN='\033[1;36m'
NC='\033[0m'

while true; do
    clear
    echo -e "${VERDE}=============================================================="
    echo -e "            MTK BOOTLOADER UNLOCKER - MODO MANUAL"
    echo -e "==============================================================${NC}"
    echo -e " 1) DESBLOQUEAR BOOTLOADER (Unlock)"
    echo -e " 2) BLOQUEAR BOOTLOADER (Lock)"
    echo -e " 3) SALIR"
    echo ""
    read -p " SELECCIONA UNA OPCIÓN: " opt
    case $opt in
        1)
            echo -e "\n[!] Conecta el equipo apagado manteniendo Vol+ y Vol-..."
            # Ejecución directa apuntando al archivo del motor
            python3 $HOME/mtkclient/mtk oem unlock
            echo -e "\nPresiona Enter para continuar..."; read ;;
        2)
            python3 $HOME/mtkclient/mtk oem lock
            echo -e "\nPresiona Enter para continuar..."; read ;;
        3) exit 0 ;;
        *) echo -e "Opción no válida"; sleep 1 ;;
    esac
done
EOF

chmod +x $PREFIX/bin/MtkUnlock

echo -e "\n${VERDE}=========================================="
echo -e "        ¡INSTALACIÓN COMPLETADA!"
echo -e "   Escribe 'MtkUnlock' para iniciar"
echo -e "==========================================${NC}"
