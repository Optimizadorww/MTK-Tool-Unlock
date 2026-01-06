#!/data/data/com.termux/files/usr/bin/bash

# Colores
VERDE='\033[1;32m'
CYAN='\033[1;36m'
NC='\033[0m'

clear
echo -e "${VERDE}=========================================="
echo -e "      INSTALANDO MTK UNLOCK PRO v2.5"
echo -e "==========================================${NC}"

# 1. Actualización e instalación de Python (Arregla el error de 'pip')
echo -e "\n${CYAN}[1/3] Instalando Python y dependencias...${NC}"
pkg update -y
pkg install python libusb clang binutils make -y

# 2. Instalación de librerías
echo -e "\n${CYAN}[2/3] Instalando librerías de desbloqueo...${NC}"
pip install --upgrade pip
pip install pyusb pyserial mtk

# 3. Creación de la interfaz (Corregido el error de EOF)
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
            echo -e "\nApaga el cel, presiona Vol+ y Vol- y conecta el USB..."
            python3 -m mtk da xml bootloader unlock
            read -p "Presiona Enter para volver..." ;;
        2)
            python3 -m mtk da xml bootloader lock
            read -p "Presiona Enter para volver..." ;;
        3) exit 0 ;;
        *) echo -e "Opción no válida"; sleep 1 ;;
    esac
done
EOF

# Dar permisos
chmod +x $PREFIX/bin/MtkUnlock

echo -e "\n${VERDE}=========================================="
echo -e "        INSTALACIÓN COMPLETADA"
echo -e "  Escribe: MtkUnlock para iniciar"
echo -e "==========================================${NC}"
