#!/data/data/com.termux/files/usr/bin/bash

# Limpieza radical
rm -rf $HOME/mtkclient
rm -f $PREFIX/bin/MtkUnlock

# 1. Instalación de paquetes (Lo único que te ha funcionado bien)
pkg update -y
pkg install python git libusb clang binutils -y

# 2. Descarga forzada del motor
cd $HOME
git clone --depth 1 https://github.com/bkerler/mtkclient.git

# 3. Instalación de librerías con el flag que tu Termux exige (Foto 1000053736)
pip install pyusb pyserial --break-system-packages

# 4. Crear el comando 'MtkUnlock' con Bypass de Ruta
cat << 'EOF' > $PREFIX/bin/MtkUnlock
#!/data/data/com.termux/files/usr/bin/bash
echo -e "\033[1;32mIniciando MTK Unlock...\033[0m"

# FORZAMOS LA RUTA REAL
cd /data/data/com.termux/files/home/mtkclient

# Ejecutamos llamando al intérprete directamente para que no diga "No such file"
python3 /data/data/com.termux/files/home/mtkclient/mtk oem unlock
EOF

chmod +x $PREFIX/bin/MtkUnlock

clear
echo -e "=========================================="
echo -e "      ¡INSTALACIÓN COMPLETADA!"
echo -e "   Escribe 'MtkUnlock' para iniciar"
echo -e "=========================================="
