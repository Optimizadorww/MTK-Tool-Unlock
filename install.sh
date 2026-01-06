#!/data/data/com.termux/files/usr/bin/bash

# 1. Limpieza total (Borramos todo rastro de la 'kagada' anterior)
rm -rf $HOME/mtkclient
rm -f $PREFIX/bin/MtkUnlock

# 2. Instalación de bases (Lo que sí sirve en tus capturas)
echo -e "\n[1/3] Instalando bases..."
pkg update -y
pkg install python git libusb clang binutils -y

# 3. DESCARGA MANUAL FORZADA (Bypass total al error de tus fotos)
echo -e "\n[2/3] Clonando motor desde GitHub..."
cd $HOME
# Usamos git para asegurar que la carpeta se cree sí o sí
git clone --depth 1 https://github.com/bkerler/mtkclient.git

# Verificamos si la carpeta realmente se creó
if [ ! -d "$HOME/mtkclient" ]; then
    echo -e "\nERROR CRÍTICO: No se pudo crear la carpeta mtkclient. Revisa tu internet."
    exit 1
fi

# 4. Instalación de librerías USB (Con el flag para no-root)
echo -e "\n[3/3] Configurando librerías..."
pip install pyusb pyserial --break-system-packages

# 5. Crear el comando con RUTA DE SISTEMA REAL
cat << 'EOF' > $PREFIX/bin/MtkUnlock
#!/data/data/com.termux/files/usr/bin/bash
clear
echo -e "=========================================="
echo -e "      XIAOMI/MTK UNLOCKER 2026"
echo -e "=========================================="

# Comando de ejecución directa
cd $HOME
