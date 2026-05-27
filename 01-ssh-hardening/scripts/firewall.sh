#!/bin/bash

# Validar que el script se ejecute como root o con sudo
if [ "$EUID" -ne 0 ]; then
  echo "Por favor, ejecuta este script usando sudo: sudo $0"
  exit 1
fi

echo "Configurando las reglas por defecto..."
ufw default deny incoming
ufw default allow outgoing

echo "Abriendo el puerto 19808/tcp..."
ufw allow 19808/tcp

echo "Habilitando el firewall (se mantendrá activo tras reiniciar)..."
# El flag --force evita que el script se pause pidiendo confirmación Y/N
ufw --force enable

echo "Estado actual del firewall:"
ufw status verbose
