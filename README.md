# Análisis Forense y Vector de Ataque: Ransomware Ryuk

**Actividad Grupal - Seguridad en los Sistemas de Información (UNIR)**

Este repositorio contiene los artefactos técnicos, evidencias y análisis del vector de ataque del ransomware **Ryuk**. El objetivo es documentar la cadena de infección completa ("Cyber Kill Chain") y proporcionar recursos para su detección y mitigación.

---

## Estructura del Repositorio

### 1. [Artefactos Forenses](./artefactos_forenses)
Evidencias simuladas de una infección típica:
* **`RyukReadMe.txt`**: Reproducción de la nota de rescate dejada por los atacantes en los directorios víctimas.
* **`extensiones_objetivo.json`**: Lista de extensiones de archivo críticas que el malware busca cifrar (bases de datos, ofimática, backups).

### 2. [Detección y Defensa (IOCs)](./deteccion_defensa)
Recursos para equipos de Blue Team y SOC:
* **`regla_ryuk.yar`**: Regla YARA didáctica basada en cadenas estáticas características del binario y comandos de post-explotación.
* **`mitre_attack_map.csv`**: Mapeo de las TTPs (Tácticas, Técnicas y Procedimientos) observadas según el marco MITRE ATT&CK.

### 3. [Simulación de Código](./simulacion_codigo)
* **`cifrado_hibrido_demo.py`**: Script conceptual en Python que demuestra el funcionamiento lógico del esquema de **Cifrado Híbrido (AES + RSA)** utilizado por Ryuk. Ilustra por qué es computacionalmente imposible recuperar los archivos sin la clave privada del atacante.

---

##  Resumen del Vector de Ataque

El análisis detalla un vector de ataque compuesto y persistente:
1.  **Acceso Inicial:** Spear-phishing o RDP expuesto.
2.  **Infección Previa:** Uso de *loaders* como **TrickBot/Emotet**.
3.  **Movimiento Lateral:** Compromiso del Controlador de Dominio y reconocimiento de red.
4.  **Impacto:** Despliegue de Ryuk, parada de servicios y cifrado masivo.

---

## Disclaimer
Este material ha sido creado exclusivamente con fines académicos para la asignatura de "Seguridad en los Sistemas de Información". Los scripts y archivos contenidos son simulaciones inofensivas y no contienen malware real.

---
**Autores:** 
