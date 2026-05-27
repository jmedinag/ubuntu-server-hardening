#!/bin/bash

set -e

echo "[+] Hardenizando la configuracion de SSH (Applying SSH hardening configuration)..."

cp configs/99-hardening-ssh.conf /etc/ssh/sshd_config.d/

systemctl restart ssh

echo "[+] SSH Hardening Aplicado correctamente (SSH hardening applied successfully)."
