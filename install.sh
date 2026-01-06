#!/data/data/com.termux/files/usr/bin/bash

# Colores
VERDE='\033[1;32m'
CYAN='\033[1;36m'
NC='\033[0m'

clear
echo -e "${VERDE}=========================================="
echo -e "      INSTALANDO MTK UNLOCK PRO v2.1"
echo -e "==========================================${NC}"

# Instalación de dependencias corregida
echo -e "\n${CYAN}[+] Configurando paquetes de sistema...${NC}"
pkg update -y
# Eliminamos libcrypt-dev y usamos paquetes compatibles
pkg install python libusb clang binutils rust make -y

echo -e "\n${CYAN}[+] Actualizando PIP y dependencias...${NC}"
pip install --upgrade pip setuptools wheel

echo -e "\n${CYAN}[+] Instalando librerías de Bypass (MTK)...${NC}"
# Instalamos las librerías necesarias una por una para evitar errores
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
    echo ""
    read -p " SELECCIONA UNA OPCIÓN: " opt

    case \$opt in
        1)
            echo -e "\n\${AMARILLO}[!] INSTRUCCIONES DE CONEXIÓN:\${NC}"
            echo -e " 1. Apaga el teléfono por completo."
            echo -e " 2. Presiona \${VERDE}VOL+\${NC} y \${VERDE}VOL-\${NC} al mismo tiempo."
            echo -e " 3. Conecta el USB mientras mantienes los botones."
            echo -e "\${CYAN}--------------------------------------------------------------\${NC}"
            echo -e " ESPERANDO DISPOSITIVO EN MODO BROM..."
            python3 -m mtk da xml bootloader unlock
            echo -e "\n\${VERDE}[✔] Proceso finalizado. Presiona ENTER para volver...\${NC}"; read ;;
        2)
            echo -e "\n\${AMARILLO}[!] Bloqueando bootloader...\${NC}"
            python3 -m mtk da xml bootloader lock
            echo -e "\nPresiona ENTER para volver..."; read ;;
        3)
            echo -e "\n\${ROJO}[!] Formateando partición de usuario...\${NC}"
            python3 -m mtk e metadata,userdata
            echo -e "\n[✔] Wipe completado. Presiona ENTER para volver..."; read ;;
        4)
            echo -e " Saliendo...\${NC}"; exit 0 ;;
        *)
            echo -e " Opción no válida."; sleep 1 ;;
    esac
done
EOF

chmod +x $PREFIX/bin/MtkUnlock

echo -e "\n${VERDE}=========================================="
echo -e "        INSTALACIÓN COMPLETADA"
echo -e "  Escribe: MtkUnlock para iniciar"
echo -e "==========================================${NC}"
