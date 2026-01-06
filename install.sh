#!/data/data/com.termux/files/usr/bin/bash

# 1. Limpieza total de carpetas mal nombradas
rm -rf $HOME/mtkclient
rm -rf $HOME/mtkclient-main
rm -f $PREFIX/bin/MtkUnlock

# 2. Instalación de paquetes base
pkg update -y
pkg install python git libusb clang binutils wget unzip -y

# 3. Descarga Directa (Método que te funcionó en la foto 1000053751)
cd $HOME
wget https://github.com/bkerler/mtkclient/archive/refs/heads/main.zip
unzip main.zip
# CORRECCIÓN CLAVE: Renombramos la carpeta para que el comando la encuentre
mv mtkclient-main mtkclient
rm main.zip

# 4. Instalación de librerías USB (Ya las tienes, pero aseguramos)
pip install pyusb pyserial --break-system-packages

# 5. Crear el comando con la RUTA CORRECTA
cat << 'EOF' > $PREFIX/bin/MtkUnlock
#!/data/data/com.termux/files/usr/bin/bash
clear
echo -e "=========================================="
echo -e "      MTK UNLOCKER - CORREGIDO"
echo -e "=========================================="

# Entramos a la carpeta ya renombrada
if [ -d "$HOME/mtkclient" ]; then
    cd $HOME/mtkclient
    python3 mtk oem unlock
else
    echo -e "ERROR: No se encontró la carpeta mtkclient."
fi
EOF

chmod +x $PREFIX/bin/MtkUnlock

clear
echo -e "=========================================="
echo -e "        ¡POR FIN INSTALADO!"
echo -e "   Escribe 'MtkUnlock' para iniciar"
echo -e "=========================================="
