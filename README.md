****************************
*  ubuntu-server-hardening *
***************************
guia de hardenización paso a paso de ubuntu 24, incluye SSH hardening, Fail2Ban, Ufw, Auditing y las mejores practicas en seguridad
Ubuntu Server Hardening

Proyecto práctico de hardening y seguridad defensiva para servidores Ubuntu 24.04 LTS.

📖 Descripción

Este repositorio documenta paso a paso el proceso de fortalecimiento (hardening) de un servidor Ubuntu 24.04, aplicando buenas prácticas de seguridad utilizadas en entornos reales de administración Linux, DevOps y ciberseguridad.

El objetivo es reducir la superficie de ataque, mejorar la protección del sistema y construir una configuración más segura y resiliente.

🎯 Objetivos del Proyecto

Fortalecer servicios críticos del sistema
Reducir vectores de ataque
Implementar controles defensivos
Automatizar configuraciones de seguridad
Documentar procedimientos reales de hardening
Crear una guía práctica y reproducible

🛡️ Fases del Hardening
✅ Fase 1 — Hardening SSH
Cambio de puerto SSH
Deshabilitar acceso root
Deshabilitar autenticación por contraseña
Uso obligatorio de llaves SSH
Reducción de intentos de autenticación
Configuración de timeouts
Restricción de usuarios permitidos
Endurecimiento del servicio OpenSSH
🚧 Fase 2 — Fail2Ban
Protección contra ataques de fuerza bruta
Configuración de jails
Protección del servicio SSH
Políticas de bloqueo
Logs y monitoreo
🚧 Fase 3 — Firewall (UFW)
Configuración segura de firewall
Reglas mínimas necesarias
Restricción de puertos
Control de tráfico entrante y saliente
🚧 Fase 4 — Auditoría del Sistema
Configuración de auditd
Monitoreo de eventos críticos
Registro de actividad
Hardening de logs
🚧 Fase 5 — File Integrity Monitoring (FIM)
Monitoreo de integridad de archivos
Detección de cambios sospechosos
Implementación de AIDE
Verificación de archivos críticos
🚧 Fase 6 — Monitoreo y Logs
Journald
Logrotate
Centralización de logs
Supervisión básica de eventos
🚧 Fase 7 — Hardening General del Sistema
Permisos y ownership
Protección de servicios
Deshabilitar componentes innecesarios
Seguridad del kernel
Sysctl hardening
🧰 Tecnologías Utilizadas
Ubuntu Server 24.04 LTS
OpenSSH
Fail2Ban
UFW
auditd
AIDE
Bash Scripting
Linux Security Best Practices
📂 Estructura del Proyecto
ubuntu-server-hardening/
│
├── README.md
│
├── 01-ssh-hardening/
│   ├── scripts/
│   ├── configs/
│   └── README.md
│
├── 02-fail2ban/
│   ├── scripts/
│   ├── configs/
│   └── README.md
│
├── 03-ufw-firewall/
│
├── 04-auditd/
│
├── 05-file-integrity-monitoring/
│
├── 06-log-monitoring/
│
└── 07-system-hardening/
⚠️ Advertencia

Las configuraciones de este repositorio deben probarse primero en entornos de laboratorio o máquinas virtuales.

Aplicar configuraciones incorrectas de hardening puede provocar pérdida de acceso remoto o interrupción de servicios.

🧪 Entorno de Pruebas

Este proyecto se desarrolla y prueba sobre:

Ubuntu Server 24.04 LTS
VPS y entornos virtualizados
Configuraciones orientadas a laboratorio y aprendizaje práctico
🚀 Objetivo Profesional

Este repositorio forma parte de una práctica continua de:

Administración Linux
Seguridad defensiva
Hardening de servidores
DevSecOps
Automatización Bash
Seguridad ofensiva y defensiva
📌 Estado del Proyecto

🚧 En desarrollo activo.

Las fases serán agregadas progresivamente junto con scripts, configuraciones y documentación técnica.

🤝 Contribuciones

Las sugerencias, mejoras y recomendaciones de seguridad son bienvenidas.

📜 Licencia

MIT License

⭐ Autor  By javiops

Desarrollado como laboratorio práctico de hardening Linux y seguridad defensiva .
