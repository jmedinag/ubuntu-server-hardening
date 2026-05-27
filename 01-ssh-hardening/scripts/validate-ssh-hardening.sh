#!/bin/bash

set -e

echo "[+] Validating SSH configuration..."

echo "\n[+] SSH Port"
sshd -T | grep port

echo "\n[+] Authentication Settings"
sshd -T | grep authentication

echo "\n[+] Root Login"
sshd -T | grep permitrootlogin

echo "\n[+] Active SSH Listeners"
ss -tulpn | grep ssh

echo "\n[+] Validation completed successfully."
