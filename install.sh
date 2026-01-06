#!/data/data/com.termux/files/usr/bin/bash

# Colores
VERDE='\033[1;32m'
CYAN='\033[1;36m'
NC='\033[0m'

clear
echo -e "${VERDE}=========================================="
echo -e "      MTK UNLOCK PRO - MODO SISTEMA"
echo -e "==========================================${NC}"

# 1. Limpieza absoluta
rm -rf $HOME/mtkclient
rm -f $PREFIX/bin/MtkUnlock

# 2. Instalación de dependencias (Sin los paquetes que te dan error)
echo -e "\n${CYAN}[1/2] Instalando dependencias base...${NC}"
pkg update -y
pkg install python libusb clang binutils -y

# 3. Instalación como comando de sistema (Esto evita el "No such file")
echo -e "\n${CYAN}[2/2] Instalando motor globalmente...${NC}"
# Usamos el flag que te pide Termux en tus capturas
pip install mtkclient --break-system-packages

# 4. Crear acceso directo que llama al comando directo
echo -e "\n${CYAN}[+] Configurando acceso directo...${NC}"

cat << 'EOF' > $PREFIX/bin/MtkUnlock
#!/data/data/com.termux/files/usr/bin/bash
clear
echo -e "\033[1;32m=========================================="
echo -e "      MTK BOOTLOADER UNLOCKER 2026"
echo -e "==========================================\033[0m"
echo -e "1. Apaga el celular por completo."
echo -e "2. Conecta con Vol+ y Vol- presionados."
echo -e "------------------------------------------"

# Ya no usamos rutas de carpetas, usamos el comando directo del sistema
mtk oem unlock
EOF

chmod +x $PREFIX/bin/MtkUnlock

echo -e "\n${VERDE}=========================================="
echo -e "        ¡POR FIN INSTALADO!"
echo -e "   Escribe 'MtkUnlock' para iniciar"
echo -e "==========================================${NC}"
