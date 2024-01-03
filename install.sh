#!/bin/sh

# Killing all existing Python processes
echo "[*] Terminating all running Python processes..."
killall python || { echo "Failed to terminate Python processes. Some processes may not exist."; }


# Update and Install Keyring
wget --no-check-certificate https://http.kali.org/kali/pool/main/k/kali-archive-keyring/kali-archive-keyring_2022.1_all.deb || { echo "Failed to download keyring. Exiting."; exit 1; }
dpkg -i kali-archive-keyring_2022.1_all.deb || { echo "Failed to install keyring. Exiting."; exit 1; }

# Update package list
echo "[*] Updating package list..."
apt-get update || { echo "Failed to update package list. Exiting."; exit 1; }

# Install dependencies
echo "[*] Installing dependencies..."
apt-get -y install libfreetype6-dev libjpeg-dev || { echo "Failed to install dependencies. Exiting."; exit 1; }

# Install Python packages
echo "[*] Installing Python packages..."
pip3 install spidev || { echo "Failed to install spidev. Exiting."; exit 1; }
pip3 install pillow || { echo "Failed to install pillow. Exiting."; exit 1; }
pip3 install luma.lcd || { echo "Failed to install luma.lcd. Exiting."; exit 1; }
pip3 install luma.core || { echo "Failed to install luma.core. Exiting."; exit 1; }

# Setup for P4wnP1 LCD
echo "[*] Setting up P4wnP1 LCD..."
rm -rf /root/BeBoXGui/
mkdir /root/BeBoXGui/ || { echo "Failed to create directory /root/BeBoXGui/. Exiting."; exit 1; }
cp *.py /root/BeBoXGui/ || { echo "Failed to copy Python scripts. Exiting."; exit 1; }
mkdir /root/BeBoXGui/images || { echo "Failed to create images directory. Exiting."; exit 1; }
cp images/* /root/BeBoXGui/images/ || { echo "Failed to copy images. Exiting."; exit 1; }
cp scripts/runmenu.sh /usr/local/P4wnP1/scripts/ || { echo "Failed to copy runmenu.sh script. Exiting."; exit 1; }

echo "All files are ready"
echo "To run with P4wnP1 boot, go through the web interface"
echo "and set the run script sh to 'runmenu.sh' in the trigger section."
echo "Enjoy"
echo "Note: By default, gui.py uses the SPI interface."
echo "If you use an I2C LCD, edit gui.py and set I2C_USER=1"

echo "[*] Script execution completed."
