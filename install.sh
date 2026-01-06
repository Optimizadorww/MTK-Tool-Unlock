#!/data/data/com.termux/files/usr/bin/bash

# 1. Limpieza total de los intentos que fallaron
rm -rf $HOME/mtkclient
rm -f $PREFIX/bin/MtkUnlock

# 2. Instalación de bases (Lo único que no te da error)
pkg update -y
pkg install python libusb clang binutils wget unzip -y

# 3. DESCARGA FORZADA (Sin usar pip ni git que te fallan)
echo -e "\nBajando archivos directamente..."
cd $HOME
wget https://github.com/bkerler/mtkclient/archive/refs/heads/main.zip
unzip main.zip
mv mtkclient-main mtkclient
rm main.zip

# 4. Instalación de librerías USB con el flag para No-Root
# Esto es lo que pedía el error rojo en tu captura 1000053736
pip install pyusb pyserial --break-system-packages

# 5. Configurar el comando con ruta física real
cat << 'EOF' > $PREFIX/bin/MtkUnlock
#!/data/data/com.termux/files/usr/bin/bash
clear
echo -e "=========================================="
echo -e "      XIAOMI/MTK UNLOCKER 2026"
echo -e "=========================================="

# Entramos a la carpeta y ejecutamos
cd /data/data/com.termux/files/home/mtkclient
python3 mtk oem unlock
EOF

chmod +x $PREFIX/bin/MtkUnlock

clear
echo -e "=========================================="
echo -e "        ¡INSTALACIÓN COMPLETADA!"
echo -e "   Escribe 'MtkUnlock' para iniciar"
echo -e "=========================================="

