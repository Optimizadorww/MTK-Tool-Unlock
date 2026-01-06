#!/data/data/com.termux/files/usr/bin/bash

# Limpieza total de lo que no sirve
rm -rf $HOME/mtkclient
rm -f $PREFIX/bin/MtkUnlock

# 1. Instalación de herramientas base (Lo que sí funciona en tus fotos)
pkg update -y
pkg install python git libusb clang binutils -y

# 2. DESCARGA MANUAL (Bypass al error de "No matching distribution")
echo -e "\nDescargando motor directamente de GitHub..."
cd $HOME
git clone --depth 1 https://github.com/bkerler/mtkclient.git

# 3. Instalación de librerías con el flag obligatorio para Android
pip install pyusb pyserial --break-system-packages

# 4. Crear el comando con RUTA ABSOLUTA REAL
cat << 'EOF' > $PREFIX/bin/MtkUnlock
#!/data/data/com.termux/files/usr/bin/bash
clear
echo -e "=========================================="
echo -e "      XIAOMI/MTK UNLOCKER 2026"
echo -e "=========================================="

# Forzamos la entrada a la carpeta física
if [ -d "$HOME/mtkclient" ]; then
    cd $HOME/mtkclient
    # Ejecutamos llamando a python3 directamente sobre el archivo
    python3 mtk oem unlock
else
    echo -e "ERROR: No se encontró la carpeta mtkclient."
fi
EOF

chmod +x $PREFIX/bin/MtkUnlock

clear
echo -e "=========================================="
echo -e "        ¡INSTALACIÓN COMPLETADA!"
echo -e "   Escribe 'MtkUnlock' para iniciar"
echo -e "=========================================="
