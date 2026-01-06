#!/data/data/com.termux/files/usr/bin/bash

# Colores
VERDE='\033[1;32m'
CYAN='\033[1;36m'
ROJO='\033[1;31m'
NC='\033[0m'

clear
echo -e "${VERDE}=========================================="
echo -e "      XIAOMI MTK UNLOCK - FIX TOTAL"
echo -e "==========================================${NC}"

# 1. ARREGLAR ERROR DE LIBCRYPT-DEV (Tu foto 1)
echo -e "\n${CYAN}[1/3] Instalando base del sistema...${NC}"
pkg update -y
pkg install python libusb clang binutils git wget -y

# 2. ARREGLAR ERROR DE PIP Y MTKCLIENT (Tus fotos 2 a 6)
echo -e "\n${CYAN}[2/3] Instalando librerías USB...${NC}"
# Forzamos solo lo esencial para que el sistema no nos bloquee
pip install pyusb pyserial --break-system-packages

# 3. ARREGLAR ERROR "NO SUCH FILE" (Tus últimas fotos)
echo -e "\n${CYAN}[3/3] Descargando motor de desbloqueo directo...${NC}"
cd $HOME
rm -rf mtkclient
# Clonamos con profundidad 1 para evitar errores de red
git clone --depth 1 https://github.com/bkerler/mtkclient.git

# 4. CREAR EL COMANDO QUE SIEMPRE FUNCIONA
echo -e "\n${CYAN}[+] Configurando comando 'MtkUnlock'...${NC}"

cat << 'EOF' > $PREFIX/bin/MtkUnlock
#!/data/data/com.termux/files/usr/bin/bash
# Interfaz corregida
clear
echo -e "\033[1;32m=========================================="
echo -e "     UNLOCKED MTK - MODO SEGURO"
echo -e "==========================================\033[0m"
echo -e "1. Celular APAGADO."
echo -e "2. Mantén presionados VOL+ y VOL-."
echo -e "3. Conecta el USB mientras presionas."
echo -e "------------------------------------------"

# Ruta forzada para evitar el error "No such file"
cd $HOME/mtkclient
python3 mtk oem unlock
EOF

chmod +x $PREFIX/bin/MtkUnlock

echo -e "\n${VERDE}=========================================="
echo -e "        ¡POR FIN INSTALADO!"
echo -e "   Escribe 'MtkUnlock' para iniciar"
echo -e "==========================================${NC}"
