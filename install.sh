#!/data/data/com.termux/files/usr/bin/bash

# Colores
VERDE='\033[1;32m'
CYAN='\033[1;36m'
NC='\033[0m'

clear
echo -e "${VERDE}=========================================="
echo -e "      MTK UNLOCK PRO - MODO MANUAL 2026"
echo -e "==========================================${NC}"

# 1. INSTALACIÓN DE BASE (Lo que sí funciona)
echo -e "\n${CYAN}[1/3] Instalando dependencias...${NC}"
pkg update -y
pkg install python git libusb clang binutils -y

# 2. DESCARGA DEL MOTOR (Sin usar PIP que da error)
echo -e "\n${CYAN}[2/3] Descargando motor de desbloqueo...${NC}"
cd $HOME
rm -rf mtkclient
git clone --depth 1 https://github.com/bkerler/mtkclient.git
cd mtkclient

# Instalamos las librerías necesarias ignorando el bloqueo de Termux
pip install pyusb pyserial --break-system-packages

# 3. CREAR EL ACCESO DIRECTO CON RUTA FORZADA
echo -e "\n${CYAN}[3/3] Configurando comando 'MtkUnlock'...${NC}"

cat << EOF > $PREFIX/bin/MtkUnlock
#!/data/data/com.termux/files/usr/bin/bash
clear
echo -e "\033[1;32m=========================================="
echo -e "      EJECUTANDO MTK UNLOCK FORZADO"
echo -e "==========================================\033[0m"
echo -e "1. Apaga el celular."
echo -e "2. Conecta con Vol+ y Vol- presionados."
echo -e "------------------------------------------"

# Ejecución directa desde la carpeta descargada
cd \$HOME/mtkclient
python3 mtk oem unlock
EOF

chmod +x $PREFIX/bin/MtkUnlock

echo -e "\n${VERDE}=========================================="
echo -e "        ¡INSTALACIÓN COMPLETADA!"
echo -e "   Escribe 'MtkUnlock' para iniciar"
echo -e "==========================================${NC}"
