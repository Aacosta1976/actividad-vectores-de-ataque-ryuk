# actividad-vectores-de-ataque-ryuk
Repositorio del análisis del ransomware Ryuk y su vector de ataque.

INFORMACION GENERAL-->
Ryuk es un ransomware dirigido a grandes organizaciones, descubierto por primera vez en 2018. Se cree qeu es una variante del ransommware Hermes, llegando a tener muchas lineas de código en común.
Es un malware que no se propaga rapidamente, sino que se utiliza en ataques dirigidos a infraestrucutras de grandes organizaciones (caza mayor).
Desde su primera aparicion este a cambiado y evolucionado significativamente:por ejemplo, versiones iniciales incluían direcciones Bitcoin fijas en la nota de rescate, pero las variantes posteriores solo ponen un correo (el rescate se negocia por email) . También se han suprimido ciertos controles anti-análisis heredados de Hermes.
En los últimos años , esta familia de ransomware ha sido una de las mas lucrativas, y continúan atacando sectores
críticos (gobiernos, salud, finanzas, manufactura) en todo el mundo. Se han observado
campañas ligadas a otras familias (especialmente el troyano TrickBot y Emotet) y adaptaciones tácticas
constantes (por ejemplo, nuevas formas de propagarlo tras ataques exitosos).

FUNCIONAMIENTO TECNICO-->
Una vez ejecutado, el malware deshabilira servicios y los procesos defensivos (en pruebas se han observado unas 180 tareas y 40 procesos detenidos).
Posteriormente explora el sistemas y la red interna para cifrar los datos mas valiosos. Para ello utiliza cifrado AES
de 256 bits por archivo y protege las claves con criptografía asimétrica (claves RSA). Según CrowdStrikey análisis forenses, Ryuk contiene internamente dos claves RSA públicas (2048 bits), mientras que las claves privadas correspondientes solo las posee el atacante. Así, cada archivo se cifra con AES-256 y luego la clave AES se cifra con la clave RSA del atacante, siguiendo una lógica similar a Hermes. Pero además de esto, Ryuk marca cada archivo cifrado con la etiqueta textual HERMES para no cifrarlo dos veces, permitiendo asi una combinacion de cifrado muy fuerte, un equipo infectado solo puede recuperarse pagando el rescate pues la clave privada necesaria no se encuentra en la maquina infectada. Ryuk incluye características avanzadas para maximizar su daño en la red interna. Por ejemplo, activaequipos en estado de espera (Wake-on-LAN) para levantarlos y montarlos como unidades de red, también implementa un ping-scanner de la red local (usandoGetAdaptersAddresses) para detectar otras subredes y recursos compartidos que pueda infectar.

VECTORES DE ATAQUE Y PROPAGACIÓN-->
Ryuk no puede llegar por si solo, los atacantes primero penetran la red de la víctima y preparan el terreno. El vector inicial mas frecuente es a través del malware dropper o troyanos bancarios. En particular, casi todos los incidentes documentados involucran al troyano TrickBot  a veces introducidos inicialmente por Emotet o a traves de campañas de phising masivas. TrickBot se difundemediante correos de spam con adjuntos maliciosos (p.ej. documentos de Word infectados con macros
de Emotet) o mediante la explotacion de RDP expuesto.
Los atacantes de Ryuk emplean varios métodos para moverse lateralmente por la red tras elcompromiso inicial:
1. Utilizacion de PowerShell ofuscado que conecta con un servidor remoto y lanza un reverseshell.
2. Utilzacion de herramientas windows cargadas externamente para reconocimiento: enumeracion de cuentas, servicios...
3. Movimiento lateral vía RDP usando las credenciales robadas.
4. Se crean cuentas con servicios con privilegios elevados.
5. Descarga e instalación de herramientas como Cobalt Strike o PowerShell Empire para
mantener acceso.
6.Uso de PSEXEC para distribuir el binario de Ryuk a otros hosts.
7.Ejecución de scripts por lotes para terminar procesos/servicios que bloqueen el cifrado y
eliminar copias de respaldo (shadow copies).
Estas etapas preparan el entorno para que ryuk encripte el maximo numero de datos posible.

Los vectores de entrada comunes son:
1.Correo phishing con enlaces/adjuntos maliciosos (principio de cadena Emotet/TrickBot)
2.Acceso RDP comprometido, por credenciales débiles o exploits, permitiendo acceso remoto al
atacante (método señalizado también en ataques de Hermes/Horus).
3.Otros droppers/malware: BazarLoader, Zloader u otros troyanos bancarios que finalmente
instalaban Ryuk

EJEMPLOS PRACTICOS-->
(aquí vendrian ejemplos prácticos de carácter técnico de ryuk)


INDICADORES DE COMPROMISO Y MITIGACION-->
Existen varios indicadores de compromiso que pueden sugerir la presencia de Ryuk o sus etapas
preliminares:
1.Extensión de archivos cifrados: Terminan en .RYK
2.Nombre de nota de rescate: Notas de texto como RyukReadMe.txt o .html.
3.Tareas programadas maliciosas:Cargas de BazarLoader: tarea con nombre StartAd-Ad en registro de Windows
4.Archivos adjuntos sospechosos: Doble extensión como *.DOC.exe
5.Ejecutables en ubicaciones inusuales:TrickBot deja un EXE de nombre aleatorio (12 caracteres) en carpetascomo C:\Windows\
6.Comunicacion con C2 conocidos: Tráfico anómalo asociado a servidores de TrickBot/Cobalt Strike
7.Ejecución de scripts remotos:Registros de PowerShell con comandos ofuscados o uso de
herramientas como PsExec.

(Aqui vendrian buenas practicas y mitigacion)




















