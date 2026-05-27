set -e

mkdir -p backups

echo "[+] Creaando Backup de configuración(Creating configuration backups)..."

cp /etc/ssh/sshd_config backups/sshd_config.bak
cp /etc/ssh/sshd_config.d/50-cloud-init.conf backups/50-cloud-init.conf.bak

echo "[+] Backup realizado con exito (Backups completed successfully)."
