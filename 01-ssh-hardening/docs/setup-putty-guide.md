********************************************************************************
*  ____  _  _ ___ ___ _   _    ____ ____ ____ ____ ____ _  _   _  _ ____       *
*  |__]  |  |  |   |   \_/     |___ |__| [__  |___ |    |  |   |\/| |  |       *
*  |     |__|  |   |    |      |    |  | ___] |___ |___ |__|   |  | |__|  2026 *
*                                                                              *
*  >> SEC-LAB-SYSTEMS // WINDOWS CLIENT ACCESS OVER SSH-KEYPAIR INFRASTRUCTURE *
********************************************************************************

================================================================================
0x01 // PRE-REQUISITOS Y CONTEXTO
================================================================================
Una vez deshabilitado el parámetro 'PasswordAuthentication', el servidor SSH 
rechazará cualquier intento de negociación basado en contraseñas tradicionales. 
Para establecer una sesión remota desde Windows utilizando PuTTY, es obligatorio 
convertir la llave privada openSSH (.id_ed25519) al formato propietario de 
PuTTY (.ppk) e inyectarla en el agente de autenticación.

[+] HERRAMIENTAS REQUERIDAS:
    - PuTTY Client (Suite completa que incluye PuTTY y PuTTYgen).
    - Acceso a la llave privada original generada en la Fase 3.

================================================================================
0x02 // FASE 1: CONVERSIÓN DE LA LLAVE CON PUTTYGEN
================================================================================
PuTTY no puede interpretar directamente el formato de llave nativo de OpenSSH, 
por lo que utilizaremos PuTTYgen para realizar la transmutación criptográfica.

[PASO 1] -> Ejecutar la aplicación 'PuTTYgen' en su entorno Windows.
[PASO 2] -> Hacer clic en 'File' -> 'Load private key' (o el botón 'Load').
[PASO 3] -> En el explorador de archivos, cambiar el filtro de extensión a 
            "All Files (*.*)" para poder visualizar archivos sin extensión.
[PASO 4] -> Seleccionar el archivo de su llave privada original (ej. 'id_ed25519')
            ubicado generalmente en: C:\Users\<Usuario>\.ssh\ misma que fue generada
	    en la fase 4 del archivo setup-guide.md
[PASO 5] -> Si la llave fue protegida con una contraseña en la Fase 3, PuTTYgen 
            solicitará la 'Passphrase'. Introdúzcala para descifrar la llave.
[PASO 6] -> El sistema mostrará un aviso: "Foreign key imported successfully".
[PASO 7] -> En la interfaz, asegúrese de que el parámetro 'Key comment' sea 
            identificable (ej. jmedina@hardening-sec-lab).
[PASO 8] -> Hacer clic en el botón 'Save private key'.
[PASO 9] -> Guardar el archivo resultante en un directorio seguro con la 
            extensión '.ppk' (ej. 'id_ed25519_hardened.ppk').

================================================================================
0x03 // FASE 2: CONFIGURACIÓN PASO A PASO DEL PERFIL EN PUTTY
================================================================================
Configuración del payload de conexión e inyección de la llave .ppk en el cliente.

[PASO 1] -> Ejecutar la aplicación 'PuTTY'.
[PASO 2] -> Panel Izquierdo: Ir a 'Session'.
            - Host Name (or IP address): 192.168.111.145
            - Port: 19808 (o el puerto personalizado configurado).
            - Connection type: SSH
[PASO 3] -> Panel Izquierdo: Desplegar 'Connection' -> 'Data'.
            - Auto-login username: jmedina
[PASO 4] -> Panel Izquierdo: Desplegar 'Connection' -> 'SSH' -> 'Auth' -> 'Credentials'.
            (* NOTA: En versiones antiguas de PuTTY se encuentra directamente en SSH -> Auth)
[PASO 5] -> En la opción "Private key file for authentication", hacer clic en 
            'Browse...' y seleccionar el archivo '.ppk' generado en la Fase 1.
[PASO 6] -> Panel Izquierdo: Regresar a la sección 'Session'.
            - En el campo 'Saved Sessions', escribir un alias (ej. Hardening-Lab-Server).
            - Hacer clic en el botón 'Save' para persistir la configuración.

================================================================================
0x04 // FASE 4: HANDSHAKE Y ESTABLECIMIENTO DE SESIÓN
================================================================================

[PASO 1] -> En la lista de 'Saved Sessions', hacer doble clic sobre el perfil 
            guardado ('Hardening-Lab-Server') o seleccionarlo y presionar 'Open'.
[PASO 2] -> Al ser la primera conexión tras el endurecimiento, PuTTY mostrará 
            un aviso de seguridad sobre la huella digital (Host Key Alert). 
            Hacer clic en 'Accept' para registrar el hash en el registro de Windows.
[PASO 3] -> La terminal de PuTTY se inicializará y mostrará el siguiente output:
            
            Authenticating with public key "jmedina@hardening-sec-lab"
            Passphrase for key "jmedina@hardening-sec-lab": 

[PASO 4] -> Introduzca la contraseña de su llave privada. 

[+] HANDSHAKE SUCCESSFUL: El servidor validará la firma digital, omitirá la 
    solicitud de password del sistema operativo y otorgará acceso al prompt seguro.

================================================================================
[EOF] // END OF FILE -- WINDOWS SSH TUNNEL OPERATIONAL // MIT LICENSE
================================================================================
