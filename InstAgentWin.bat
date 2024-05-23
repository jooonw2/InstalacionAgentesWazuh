@echo off
:: Solicita permisos de administrador
NET SESSION >NUL 2>NUL
if %errorlevel% neq 0 (
    echo Requesting administrative privileges ...
    powershell.exe -Command "Start-Process -FilePath '%comspec%' -ArgumentList '/c \"%~s0\"' -Verb RunAs"
    exit /B
)

:: Descarga el archivo MSI del agente de Wazuh
powershell.exe -Command "Invoke-WebRequest -Uri https://packages.wazuh.com/4.x/windows/wazuh-agent-4.7.3-1.msi -OutFile ${env.tmp}\wazuh-agent; msiexec.exe /i ${env.tmp}\wazuh-agent /q WAZUH_MANAGER='192.168.50.11' WAZUH_AGENT_GROUP='WIndows' WAZUH_REGISTRATION_SERVER='192.168.50.11' "

:: Espera 10 segundos para que la instalación del agente se complete
timeout /t 10

:: Si la instalación fue exitosa, iniciar el servicio
if %errorlevel% equ 0 (
    NET START WazuhSvc
) else (
    echo Error: La instalación del agente de Wazuh ha fallado.
)
