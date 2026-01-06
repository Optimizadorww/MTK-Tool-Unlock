#!/data/data/com.termux/files/usr/bin/bash

# Colores
VERDE='\033[1;32m'
CYAN='\033[1;36m'
ROJO='\033[1;31m'
NC='\033[0m'

clear
echo -e "${VERDE}=========================================="
echo -e "      XIAOMI MTK UNLOCK PRO v8.0"
echo -e "==========================================${NC}"

# 1. Forzar instalación de Python y Pip limpio
echo -e "\n${CYAN}[1/2] Instalando dependencias críticas...${NC}"
pkg update -y
pkg install python python-pip libusb git clang -y

# 2. Instalar mtkclient de forma global (Saltando el bloqueo de Termux)
echo -e "\n${CYAN}[2/2] Instalando motor de desbloqueo...${NC}"
# Usamos el flag oficial para permitir la instalación en sistemas protegidos
pip install mtkclient --break-system-packages

# 3. Crear el acceso directo que usa el comando GLOBAL
echo -e "\n${CYAN}[+] Configurando interfaz...${NC}"

cat << 'EOF' > $PREFIX/bin/MtkUnlock
#!/data/data/com.termux/files/usr/bin/bash
VERDE='\033[1;32m'
CYAN='\033[1;36m'
NC='\033[0m'

while true; do
    clear
    echo -e "${VERDE}=============================================================="
    echo -e "            UNLOCKED MTK - MODO BINARIO DIRECTO"
    echo -e "==============================================================${NC}"
    echo -e " 1) DESBLOQUEAR BOOTLOADER (Unlock)"
    echo -e " 2) BLOQUEAR BOOTLOADER (Lock)"
    echo -e " 3) SALIR"
    echo ""
    read -p " SELECCIONA: " opt
    case $opt in
        1)
            echo -e "\n[!] Conecta el cel apagado (Vol+ y Vol-)..."
            # Aquí ya no usamos rutas raras, usamos el comando directo del sistema
            mtk oem unlock
            echo -e "\nPresiona Enter para volver..."; read ;;
        2)
            mtk oem lock
            echo -e "\nPresiona Enter para volver..."; read ;;
        3) exit 0 ;;
        *) echo -e "Opción no válida"; sleep 1 ;;
    esac
done
EOF

chmod +x $PREFIX/bin/MtkUnlock

echo -e "\n${VERDE}=========================================="
echo -e "        ¡POR FIN INSTALADO!"
echo -e "   Escribe 'MtkUnlock' para iniciar"
echo -e "==========================================${NC}"
