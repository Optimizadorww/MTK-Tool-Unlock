#!/data/data/com.termux/files/usr/bin/bash

# Colores
VERDE='\033[1;32m'
CYAN='\033[1;36m'
NC='\033[0m'

clear
echo -e "${VERDE}=========================================="
echo -e "      MTK UNLOCK PRO - MODO SISTEMA"
echo -e "==========================================${NC}"

# 1. Limpieza total de lo que no funcionó
rm -rf $HOME/mtkclient
rm -f $PREFIX/bin/MtkUnlock

# 2. Instalación de paquetes base
echo -e "\n${CYAN}[1/2] Instalando dependencias base...${NC}"
pkg update -y
pkg install python libusb clang binutils -y

# 3. Instalación GLOBAL (Esto evita el "No such file")
echo -e "\n${CYAN}[2/2] Instalando motor de desbloqueo...${NC}"
# Usamos el flag obligatorio para Android sin Root
pip install mtkclient --break-system-packages

# 4. Crear acceso directo directo al binario de sistema
echo -e "\n${CYAN}[+] Configurando acceso directo...${NC}"

cat << 'EOF' > $PREFIX/bin/MtkUnlock
#!/data/data/com.termux/files/usr/bin/bash
clear
echo -e "\033[1;32m=========================================="
echo -e "      XIAOMI/MTK BOOTLOADER UNLOCKER"
echo -e "==========================================\033[0m"
echo -e "1. Apaga el celular por completo."
echo -e "2. Conecta con Vol+ y Vol- presionados."
echo -e "------------------------------------------"

# Ejecutamos el comando de sistema, sin usar rutas de carpetas
mtk oem unlock
EOF

chmod +x $PREFIX/bin/MtkUnlock

echo -e "\n${VERDE}=========================================="
echo -e "        ¡POR FIN INSTALADO!"
echo -e "   Escribe 'MtkUnlock' para iniciar"
echo -e "==========================================${NC}"
