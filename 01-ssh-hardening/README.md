🔐 SSH Hardening — Ubuntu Server 24.04 LTS

Implementación de hardening para el servicio OpenSSH aplicando principios de reducción de superficie de ataque, autenticación segura y administración defensiva en Linux.

📖 Descripción

Esta fase del proyecto se enfoca en fortalecer el servicio SSH en Ubuntu Server 24.04 LTS mediante configuraciones orientadas a seguridad defensiva y endurecimiento del acceso remoto.

El objetivo principal es minimizar vectores de ataque comunes como:

Fuerza bruta
Acceso no autorizado
Uso de credenciales débiles
Escalación de privilegios
Configuraciones inseguras por defecto
🎯 Objetivos de Seguridad
Eliminar autenticación por contraseña
Obligar el uso de llaves criptográficas
Deshabilitar acceso remoto del usuario root
Reducir intentos de autenticación
Aumentar control sobre sesiones SSH
Aplicar configuración modular mantenible
Seguir buenas prácticas modernas de administración Linux
🧰 Tecnologías Utilizadas
Ubuntu Server 24.04 LTS
OpenSSH
ED25519 Keys
Bash
UFW (posteriormente)
Fail2Ban (posteriormente)
📋 Requisitos Previos
Acceso administrativo al servidor
Usuario con privilegios sudo
Cliente SSH instalado
Conectividad de red entre cliente y servidor
🛠️ Fase 1 — Actualización del Sistema

Actualizar el sistema antes de aplicar configuraciones de seguridad.

sudo apt update && sudo apt upgrade -y
sudo apt install unattended-upgrades -y
¿Por qué es importante?

Mantener el sistema actualizado reduce la exposición a vulnerabilidades conocidas y permite recibir parches de seguridad automáticamente.

🔎 Fase 2 — Auditoría Inicial

Antes de modificar configuraciones críticas, es importante conocer el estado actual del servidor.

Verificar puertos y servicios expuestos
ss -tulpn
Listar servicios activos
systemctl list-units --type=service --state=running
Verificar estado del firewall
sudo ufw status
Crear evidencia inicial de auditoría
mkdir logs
ss -tulpn > logs/initial-audit.txt
🔑 Fase 3 — Generación de Llaves SSH
Generar llave ED25519 desde el cliente
ssh-keygen -t ed25519 -C "jmedina@hardening-sec-lab"
¿Por qué ED25519?

ED25519 ofrece:

Mayor seguridad criptográfica
Mejor rendimiento
Llaves más pequeñas
Protección moderna contra ataques criptográficos
📤 Copiar la Llave Pública al Servidor

Desde PowerShell en Windows:

type $env:USERPROFILE\.ssh\id_ed25519.pub | ssh -p 19808 jmedina@192.168.111.145 "cat >> ~/.ssh/authorized_keys"
⚙️ Arquitectura de Configuración SSH

Ubuntu utiliza dos archivos principales relacionados con SSH:

Archivo	Función
/etc/ssh/sshd_config	Configuración del servidor SSH
/etc/ssh/ssh_config	Configuración del cliente SSH
🛡️ Hardening Modular de OpenSSH
Buenas Prácticas Modernas

En lugar de modificar directamente:

/etc/ssh/sshd_config

se implementa una configuración modular utilizando:

/etc/ssh/sshd_config.d/

Este enfoque:

Mejora mantenibilidad
Facilita auditorías
Reduce errores administrativos
Permite rollback más seguro
Sigue estándares modernos de Linux
📁 Crear Archivo de Hardening

Crear el archivo:

/etc/ssh/sshd_config.d/99-hardening-ssh.conf
Configuración Recomendada
Port 19808

PermitRootLogin no
PasswordAuthentication no
KbdInteractiveAuthentication no

X11Forwarding no
MaxAuthTries 3

ClientAliveInterval 300
ClientAliveCountMax 2

Protocol 2

AllowTcpForwarding no
AllowAgentForwarding no

LoginGraceTime 30

PermitEmptyPasswords no

UsePAM yes
🔍 Explicación de Configuraciones Críticas
Configuración	Propósito
PermitRootLogin no	Bloquea acceso SSH directo al usuario root
PasswordAuthentication no	Obliga autenticación mediante llaves SSH
MaxAuthTries 3	Limita intentos de autenticación
X11Forwarding no	Reduce superficie de ataque
ClientAliveInterval 300	Detecta sesiones inactivas
AllowTcpForwarding no	Deshabilita túneles SSH innecesarios
PermitEmptyPasswords no	Bloquea cuentas sin contraseña
📌 Habilitar Configuración Modular

Verificar que el archivo principal incluya:

Include /etc/ssh/sshd_config.d/*.conf

dentro de:

/etc/ssh/sshd_config
☁️ Consideración Especial — Cloud Images

En algunos entornos cloud, Ubuntu utiliza:

/etc/ssh/sshd_config.d/50-cloud-init.conf

Si existe:

PasswordAuthentication yes

debe modificarse a:

PasswordAuthentication no

para evitar conflictos de configuración.

✅ Validar Configuración SSH

Antes de reiniciar el servicio:

sudo sshd -t
🔄 Reiniciar Servicio SSH
sudo systemctl restart ssh
🧪 Validación de Acceso

Conectarse utilizando:

ssh -p 19808 jmedina@192.168.111.145

El acceso ahora se realizará exclusivamente mediante:

llave privada SSH
passphrase configurada localmente
🔒 Beneficios de Seguridad Obtenidos

✅ Eliminación de autenticación insegura por contraseña

✅ Reducción de ataques automatizados

✅ Protección contra fuerza bruta básica

✅ Separación modular de configuración

✅ Menor superficie de ataque

✅ Administración más mantenible

⚠️ Recomendaciones Importantes
Nunca deshabilitar autenticación por contraseña antes de probar acceso por llave SSH
Mantener una sesión SSH activa durante cambios críticos
Validar configuraciones con sshd -t
Realizar backups antes de modificar archivos del sistema
📂 Estructura Recomendada del Proyecto
01-ssh-hardening/
│
├── README.md
│
├── scripts/
│   ├── harden-ssh.sh
│   ├── backup-ssh.sh
│   └── rollback-ssh.sh
│
├── configs/
│   └── 99-hardening-ssh.conf
│
└── logs/
    └── initial-audit.txt
🚀 Próxima Fase
Fail2Ban

La siguiente etapa implementará protección activa contra:

ataques de fuerza bruta
escaneo automatizado
intentos reiterados de autenticación
📜 Licencia

MIT License

⭐ Autor

Proyecto práctico de hardening Linux orientado a administración defensiva, DevSecOps y seguridad de servidores.
