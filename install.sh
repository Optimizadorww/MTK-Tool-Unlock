#!/data/data/com.termux/files/usr/bin/bash

# Colores
VERDE='\033[1;32m'
CYAN='\033[1;36m'
NC='\033[0m'

clear
echo -e "${VERDE}=========================================="
echo -e "      INSTALANDO MTK UNLOCK PRO v2.0"
echo -e "==========================================${NC}"

# Instalación de dependencias
echo -e "\n${CYAN}[+] Configurando paquetes de sistema...${NC}"
pkg update -y
pkg install python libusb clang libcrypt-dev -y

echo -e "\n${CYAN}[+] Instalando librerías de Bypass (MTK)...${NC}"
pip install pyusb pyserial mtk

# CREACIÓN DE LA HERRAMIENTA CON INTERFAZ
echo -e "\n${CYAN}[+] Creando interfaz de usuario...${NC}"

cat <<EOF > $PREFIX/bin/MtkUnlock
#!/data/data/com.termux/files/usr/bin/bash

# Colores Interfaz
VERDE='\033[1;32m'
ROJO='\033[1;31m'
AMARILLO='\033[1;33m'
CYAN='\033[1;36m'
NC='\033[0m'

while true; do
    clear
    echo -e "\${VERDE}  __  __ _______ _  __  _    _ _   _ _      ____   _____ _  __"
    echo -e " |  \/  |__   __| |/ / | |  | | \ | | |    / __ \ / ____| |/ /"
    echo -e " | \  / |  | |  | ' /  | |  | |  \| | |   | |  | | |    | ' / "
    echo -e " | |\/| |  | |  |  <   | |  | | . \` | |   | |  | | |    |  <  "
    echo -e " | |  | |  | |  | . \  | |__| | |\  | |___| |__| | |____| . \ "
    echo -e " |_|  |_|  |_|  |_|\_\  \____/|_| \_|______\____/ \_____|_|\_\\"
    echo -e " \${CYAN}=============================================================="
    echo -e "            BYPASS BOOTLOADER - MTK NO WAIT 2026"
    echo -e " ==============================================================\${NC}"
    echo -e " \${CYAN}1)\${NC} \${VERDE}DESBLOQUEO INSTANTÁNEO (Unlock)\${NC}"
    echo -e " \${CYAN}2)\${NC} RE-BLOQUEAR BOOTLOADER (Relock)"
    echo -e " \${CYAN}3)\${NC} LIMPIAR DATOS (Wipe Data / Factory Reset)"
    echo -e " \${CYAN}4)\${NC} SALIR"
    
