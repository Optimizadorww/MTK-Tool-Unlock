#!/data/data/com.termux/files/usr/bin/bash

# Colores
VERDE='\033[1;32m'
CYAN='\033[1;36m'
NC='\033[0m'

clear
echo -e "${VERDE}=========================================="
echo -e "      INSTALANDO MTK UNLOCK PRO v2.7"
echo -e "==========================================${NC}"

# 1. Instalación de paquetes (Sin actualizar pip para evitar el error rojo)
echo -e "\n${CYAN}[1/3] Instalando herramientas base...${NC}"
pkg update -y
pkg install python python-pip libusb clang binutils make -y

# 2. Instalación de mtkclient (La librería correcta)
echo -e "\n${CYAN}[2/3] Instalando herramientas de desbloqueo...${NC}"
# Usamos --break-system-packages porque Termux lo exige ahora para pip
pip install pyusb pyserial mtkclient --break-system-packages

# 3. Creación de la interfaz corregida
echo -e "\n${CYAN}[3/3] Creando acceso directo 'MtkUnlock'...${NC}"

cat << 'EOF' > $PREFIX/bin/MtkUnlock
#!/data/data/com.termux/files/usr/bin/bash
VERDE='\033[1;32m'
CYAN='\033[1;36m'
NC='\033[0m'

while true; do
    clear
    echo -e "${VERDE}  __  __ _______ _  __  _    _ _   _ _      ____   _____ _  __"
    echo -e " |  \/  |__   __| |/ / | |  | | \ | | |    / __ \ / ____| |/ /"
    echo -e " | \  / |  | |  | ' /  | |  | |  \| | |   | |  | | |    | ' / "
    echo -e " | |\/| |  | |  |  <   | |  | | . \` | |   | |  | | |    |  <  "
    echo -e " | |  | |  | |  | . \  | |__| | |\  | |___| |__| | |____| . \ "
    echo -e " |_|  |_|  |_|  |_|\_\  \____/|_| \_|______\____/ \_____|_|\_\\"
    echo -e " ${CYAN}=============================================================="
    echo -e "            BYPASS BOOTLOADER - MTK NO WAIT 2026"
    echo -e " ==============================================================${NC}"
    echo -e " 1) DESBLOQUEO INSTANTÁNEO (Unlock)"
    echo -e " 2) RE-BLOQUEAR BOOTLOADER (Relock)"
    echo -e " 3) SALIR"
    echo ""
    read -p " OPCIÓN: " opt
    case $opt in
        1)
            echo -e "\nConecta el cel apagado con Vol+ y Vol-..."
            # Comando oficial de mtkclient
            python3 -m mtk oem unlock
            read -p "Presiona Enter para volver..." ;;
        2)
            python3 -m mtk oem lock
            read -p "Presiona Enter para volver..." ;;
        3) exit 0 ;;
        *) echo -e "Opción no válida"; sleep 1 ;;
    esac
done
EOF

chmod +x $PREFIX/bin/MtkUnlock

echo -e "\n${VERDE}=========================================="
echo -e "        INSTALACIÓN COMPLETADA"
echo -e "  Escribe: MtkUnlock para iniciar"
echo -e "==========================================${NC}"
