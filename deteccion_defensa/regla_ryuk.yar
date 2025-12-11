rule Ryuk_Ransomware_Detection {
    meta:
        description = "Regla didáctica para detección de firmas de Ryuk"
        author = "Grupo de Seguridad UNIR"
        date = "2023-12-11"
        reference = "https://attack.mitre.org/software/S0446/"
    strings:
        // Cadenas de texto comunes en el binario o notas
        $magic_header = "RyukReadMe" ascii wide
        $extension = ".ryk" ascii wide
        $admin_cmd = "vssadmin Delete Shadows /all /quiet" ascii wide
        
        // Comportamiento sospechoso
        $shutdown_srv = "net stop audio" ascii wide
    condition:
        // Se activa si encuentra la cabecera O el comando de borrado de backups
        $magic_header or $admin_cmd
}