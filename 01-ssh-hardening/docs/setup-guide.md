********************************************************************************
*  __     _  _     _  _ _ ____ ____    _  _ ____ ___  _ _  _ ____            *
*  | |__  |__| \_  |/\| | [__  |___    |\/| |___ |  \ | |\ | |__|            *
*  |____  |  |  /_ |  | | ___] |___    |  | |___ |__/ | | \| |  |   2026     *
*                                                                              *
*  >> SEC-LAB-SYSTEMS // SECURE SHELL INFRASTRUCTURE HARDENING REGIME          *
********************************************************************************

================================================================================
0x01 // RESUMEN EJECUTIVO
================================================================================
Este documento técnico describe el protocolo  para la mitigación de 
vectores de ataque en el deamon OpenSSH (sshd). Se implementa un patrón de 
diseño modular de anulación (drop-in files) para inyectar directivas de seguridad 
estrictas sin alterar la configuración  del sistema base.

[+] LOGROS DE SEGURIDAD:
    - Autenticación Zero-Password (criptografía asimétrica obligatoria).
    - Inhabilitación de vectores de escalada directa (Root Login = Disabled).
    - Minimización de superficie de ataque (X11 & Legacy protocols = Closed).
    - Control estricto del ciclo de vida de sockets inactivos.

================================================================================
0x02 // FASE 1: ACTUALIZACIÓN Y PARCHEO AUTOMATIZADO
================================================================================
Reducción proactiva de la ventana de exposición mediante la actualización de los 
índices del sistema y el aprovisionamiento de parches desatendidos.

# Actualizar el gestor de paquetes 
$ sudo apt update && sudo apt upgrade -y

# Instalar y forzar reconfiguración del daemon de actualizaciones críticas
$ sudo apt install unattended-upgrades -y
$ sudo dpkg-reconfigure --priority=low unattended-upgrades

================================================================================
0x03 // FASE 2: AUDITORÍA INICIAL Y LÍNEA BASE DE SEGURIDAD
================================================================================
Captura del estado volátil de la red, sockets de escucha y telemetría de 
servicios activos antes de aplicar la reconfiguración.

# Inicializar estructura de directorios para registros
$ mkdir -p logs

# Volcado de telemetría a almacenamiento persistente
$ ss -tulpn > logs/initial-audit.txt
$ systemctl list-units --type=service --state=running >> logs/initial-audit.txt
$ sudo ufw status >> logs/initial-audit.txt

================================================================================
0x04 // FASE 3: GESTIÓN DE LLAVES CRIPTOGRÁFICAS
================================================================================
Despliegue de un algoritmo criptográfico moderno de curva elíptica (Ed25519) 
en sustitución de esquemas RSA obsoletos.

[CLIENT-SIDE] -> Generación en terminal local (Windows / Unix):
--------------------------------------------------------------------------------
$ ssh-keygen -t ed25519 -a 100 -C "jmedina@hardening-sec-lab"
(* NOTA: Cifrar la llave privada localmente utilizando un passphrase robusto)

[PIPELINE] -> Transferencia segura a través de túnel de PowerShell:
--------------------------------------------------------------------------------
$ type $env:USERPROFILE\.ssh\id_ed25519.pub | ssh -p 19808 jmedina@192.168.111.145 "mkdir -p ~/.ssh && chmod 700 ~/.ssh && cat >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys"

================================================================================
0x05 // FASE 4: CONFIGURACIÓN SEGMENTADA DEL DEMONIO (SSHD)
 ssh-keygen -t ed25519 -a 100 -C "jmedina@hardening-sec-lab"================================================================================

[!] COMPRENSIÓN DE LA ARQUITECTURA DE ARCHIVOS:
    - /etc/ssh/ssh_config  :: Configuración del Cliente (Conexiones Outbound).
    - /etc/ssh/sshd_config :: Configuración del Servidor (Conexiones Inbound).

[+] INYECTANDO EL MODULAR OVERRIDE PATTERN:
Para preservar la integridad estructural del sistema, no modificaremos de forma 
directa el archivo maestro. Validar primero que /etc/ssh/sshd_config contenga:
"Include /etc/ssh/sshd_config.d/*.conf"

Proceder a instanciar nuestro archivo drop-in de seguridad:
$ sudo nano /etc/ssh/sshd_config.d/99-hardening-ssh.conf

[ CONTENIDO DEL ARCHIVO: 99-hardening-ssh.conf ]
--------------------------------------------------------------------------------
# ========================================================================
# HIGH-SECURITY HARDENING BASELINE - OPENSSH DAEMON
# ========================================================================

# PROTOCOL REQUERIDO
Protocol 2                 # Deniega conexiones heredadas de SSH-1

# AUTENTICACIÓN Y CONTROL DE ACCESO
PermitRootLogin no         # Deniega login directo al superusuario root
PasswordAuthentication no  # Deshabilita contraseñas; fuerza criptografía asimétrica
MaxAuthTries 3             # Limita reintentos por socket para mitigar fuerza bruta

# CONTROL DE SESIÓN Y REDUCCIÓN DE SUPERFICIE
X11Forwarding no           # Inhabilita el reenvío de interfaces gráficas X11
ClientAliveInterval 300    # Envía paquetes de sondeo cada 300 seg (5 minutos)
ClientAliveCountMax 0      # Desconexión inmediata al primer fallo de respuesta
--------------------------------------------------------------------------------
Guardamos el archivo con esta configuración

[CRÍTICO] -> EVITAR CONTRAMEDIDAS DE CLOUD-INIT:
En entornos de nube, cloud-init suele sobreescribir las políticas de acceso. 
Auditar el archivo `/etc/ssh/sshd_config.d/50-cloud-init.conf` y cerciorarse de 
que la directiva esté configurada estrictamente como:
PasswordAuthentication no

================================================================================
0x06 // FASE 5: VALIDACIÓN SINTÁCTICA Y DESPLIEGUE EN CALIENTE
================================================================================

# 1. Ejecutar análisis estático de sintaxis (Previene cierres patronales/lockouts)
$ sudo sshd -t

# 2. Si el código de salida es 0 (sin errores), reiniciar el socket del demonio
$ sudo systemctl restart ssh

# 3. Validar handshake y conexión persistente desde host local:
$ ssh -p 19808 jmedina@192.168.111.145

================================================================================
[EOF] // END OF FILE -- SYSTEM SECURED BY JMEDINA   javiops  // MIT LICENSE
================================================================================
