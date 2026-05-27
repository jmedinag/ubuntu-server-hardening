#!/bin/bash

set -e

mkdir -p audits

echo "[+] ejecutando audiroria inicial (Running initial audit)..."

ss -tulpn > audits/initial-network-exposure.txt
systemctl list-units --type=service --state=running > audits/running-services.txt
ufw status verbose > audits/firewall-status.txt

echo "[+] Auditoria ejecutada de forma exitosa (Audit completed successfully)."
