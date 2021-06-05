#!/bin/bash

#Crear la carpeta padre en RAM, con tamano de 10MB
sudo mount -t tmpfs -o size=10m myramdisk /var/tmp
#Solicitar al servidor el envío de las llaves para desencriptar el código del proyecto
#Llaves que se almacenan en RAM
scp -i ~/Macro/ProyectoFinal_key.pem azure@13.85.68.97:/home/azure/private.pem /var/tmp/private.pem
scp -i ~/Macro/ProyectoFinal_key.pem azure@13.85.68.97:/home/azure/aesKey.txt.crypted /var/tmp/aesKey.txt.crypted
#Proceso de desencriptado de los archivos del proyecto. Luego son movidos a la carpeta en RAM
openssl rsautl -decrypt -inkey /var/tmp/private.pem -in /var/tmp/aesKey.txt.crypted -out /var/tmp/aesKey.txt.decrypted
openssl enc -d -aes-256-cbc -in ~/Macro/enviar.sh.enc -out /var/tmp/enviar.sh -pass file:/var/tmp/aesKey.txt.decrypted
openssl enc -d -aes-256-cbc -in ~/Macro/grabar.sh.enc -out /var/tmp/grabar.sh -pass file:/var/tmp/aesKey.txt.decrypted
openssl enc -d -aes-256-cbc -in ~/Macro/multi.py.enc -out /var/tmp/multi.py -pass file:/var/tmp/aesKey.txt.decrypted

#Ejecucion del programa con el multiproceso.
python3 /var/tmp/multi.py
