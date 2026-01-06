#!/data/data/com.termux/files/usr/bin/bash

# Colores
VERDE='\033[1;32m'
CYAN='\033[1;36m'
NC='\033[0m'

clear
echo -e "${VERDE}=========================================="
echo -e "      MTK UNLOCK PRO v7.0 - FIX FINAL"
echo -e "==========================================${NC}"

# 1. Limpieza total
rm -rf $HOME/mtkclient
rm -f $PREFIX/bin/MtkUnlock

# 2. Instalación de paquetes (Sin libcrypt-dev que da error)
echo -e "\n${CYAN}[1/2] Instalando paquetes base...${NC}"
pkg update -y
pkg install python python-pip libusb clang git binutils -y

# 3. Instalación de la herramienta
echo -e "\n${CYAN}[2/2] Instalando motor de desbloqueo...${NC}"
# Forzamos la instalación de mtkclient de una forma que Termux acepte
pip install mtkclient --break-system-packages

# 4. Crear el comando con ruta automática
echo -e "\n${CYAN}[+] Configurando acceso directo...${NC}"

cat << 'EOF' > $PREFIX/bin/MtkUnlock
#!/data/data/com.termux/files/usr/bin/bash
VERDE='\033[1;32m'
CYAN='\033[1;36m'
NC='\033[0m'

while true; do
    clear
    echo -e "${VERDE}=============================================================="
    echo -e "            MTK BOOTLOADER UNLOCKER - 2026"
    echo -e "==============================================================${NC}"
    echo -e " 1) DESBLOQUEAR BOOTLOADER (Unlock)"
    echo -e " 2) BLOQUEAR BOOTLOADER (Lock)"
    echo -e " 3) SALIR"
    echo ""
    read -p " SELECCIONA: " opt
    case $opt in
        1)
            echo -e "\n[!] Conecta el cel apagado (Vol+ y Vol-)..."
            # Usamos el comando directo que crea la instalación de pip
            mtk oem unlock
            echo -e "\nPresiona Enter para volver..."; read ;;
        2)
            mtk oem lock
            echo -e "\nPresiona Enter para volver..."; read ;;
        3) exit 0 ;;
    esac
done
EOF

chmod +x $PREFIX/bin/MtkUnlock

echo -e "\n${VERDE}=========================================="
echo -e "        ¡INSTALACIÓN COMPLETADA!"
echo -e "   Escribe 'MtkUnlock' para iniciar"
echo -e "==========================================${NC}"
