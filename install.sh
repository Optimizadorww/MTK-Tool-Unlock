#!/data/data/com.termux/files/usr/bin/bash

# Colores
VERDE='\033[1;32m'
CYAN='\033[1;36m'
NC='\033[0m'

clear
echo -e "${VERDE}=========================================="
echo -e "      MTK UNLOCK PRO - SOLUCIÓN FINAL"
echo -e "==========================================${NC}"

# 1. ARREGLAR ERROR DE PAQUETES (Foto 1)
# Eliminamos libcrypt-dev y forzamos la actualización de repositorios
echo -e "\n${CYAN}[1/3] Actualizando sistema...${NC}"
pkg update -y && pkg upgrade -y
pkg install python libusb clang git binutils -y

# 2. ARREGLAR ERROR DE PIP (Fotos 2 a 6)
# Usamos el comando que salta el bloqueo de Termux (visto en tus errores)
echo -e "\n${CYAN}[2/3] Instalando librerías críticas...${NC}"
pip install pyusb pyserial mtkclient --break-system-packages

# 3. ARREGLAR ERROR "NO SUCH FILE" (Tus últimas fotos)
# En lugar de buscar carpetas, usamos el comando directo que instala PIP
echo -e "\n${CYAN}[3/3] Configurando acceso directo...${NC}"

cat << 'EOF' > $PREFIX/bin/MtkUnlock
#!/data/data/com.termux/files/usr/bin/bash
clear
echo -e "\033[1;32m=========================================="
echo -e "      XIAOMI/MTK BOOTLOADER UNLOCKER"
echo -e "==========================================\033[0m"
echo -e "1. Apaga el celular."
echo -e "2. Mantén Vol+ y Vol- presionados."
echo -e "3. Conecta el USB mientras presionas."
echo -e "------------------------------------------"

# Ejecutamos el comando global (esto evita el error de "No such file")
mtk oem unlock
EOF

chmod +x $PREFIX/bin/MtkUnlock

echo -e "\n${VERDE}=========================================="
echo -e "        ¡INSTALACIÓN COMPLETADA!"
echo -e "   Escribe 'MtkUnlock' para iniciar"
echo -e "==========================================${NC}"
