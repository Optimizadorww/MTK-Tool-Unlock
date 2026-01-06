#!/data/data/com.termux/files/usr/bin/bash

# Colores
VERDE='\033[1;32m'
CYAN='\033[1;36m'
NC='\033[0m'

clear
echo -e "${VERDE}=========================================="
echo -e "      INSTALANDO MTK UNLOCK PRO v2.2"
echo -e "==========================================${NC}"

# 1. ACTUALIZACIÓN DE REPOS (Paso crítico)
echo -e "\n${CYAN}[1/3] Actualizando repositorios...${NC}"
pkg update -y && pkg upgrade -y

# 2. INSTALACIÓN DE DEPENDENCIAS (Sin libcrypt-dev)
echo -e "\n${CYAN}[2/3] Instalando herramientas base...${NC}"
# Solo instalamos lo estrictamente necesario y disponible
pkg install python libusb clang binutils rust make setup-termux-hints -y

# 3. INSTALACIÓN DE LIBRERÍAS PYTHON
echo -e "\n${CYAN}[3/3] Configurando herramientas de desbloqueo...${NC}"
# Instalamos wheel primero para evitar errores de compilación
pip install --upgrade pip
pip install wheel
pip install pyusb pyserial mtk

# --- CREACIÓN DE LA INTERFAZ (Mismo diseño pro) ---
echo -e "\n${CYAN}[+] Creando acceso directo 'MtkUnlock'...${NC}"

cat <<EOF > $PREFIX/bin/MtkUnlock
#!/data/data/com.termux/files/usr/bin/bash
# (Aquí va el código de la interfaz que ya teníamos)
VERDE='\033[1;32m'
CYAN='\033[1;36m'
NC='\033[0m'

while true; do
    clear
    echo -e "\${VERDE}  __  __ _______ _  __  _    _ _   _ _      ____   _____ _  __"
    echo -e " |  \/  |__   __| |/ / | |  | | \ | | |    / __ \ / ____| |/ /"
    echo -e " | \  / |  | |  | ' /  | |  | |  \| | |   | |  | | |    | ' / "
    echo -e " | |\/| |  | |  |  
    
