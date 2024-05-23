# Scripts de Automatización para la Implementación de Clientes Wazuh

Este repositorio contiene scripts diseñados para automatizar la implementación de los clientes de Wazuh en sistemas operativos Windows y Linux (Ubuntu). A continuación, se detalla el uso y funcionamiento de cada uno de los archivos incluidos.

## Contenido del Repositorio

- **InstAgentWin.bat**: Script por lotes para la instalación del agente Wazuh en sistemas Windows.
- **InstAgentLx.sh**: Script de shell para la configuración inicial de Ansible y la implementación del agente Wazuh en sistemas Ubuntu.
- **instalar.yml**: Playbook de Ansible necesario para la instalación del agente Wazuh en sistemas Ubuntu. Este archivo debe estar ubicado en la carpeta de Ansible.

## Instrucciones de Uso

### Instalación en Windows

1. Clone este repositorio en la máquina Windows donde desea instalar el cliente Wazuh.
2. Navegue hasta el directorio del repositorio clonado.
3. Ejecute el archivo `InstAgentWin.bat` haciendo doble clic en él o desde una ventana de comandos con privilegios de administrador:

    ```sh
    InstAgentWin.bat
    ```

   Este script descargará e instalará automáticamente el agente Wazuh en su sistema Windows.

### Instalación en Ubuntu

1. Clone este repositorio en la máquina Ubuntu donde desea instalar el cliente Wazuh.
2. Asegúrese de tener Ansible instalado y configurado en su sistema.
3. Navegue hasta el directorio del repositorio clonado.
4. Ejecute el script `InstAgentLx.sh` para configurar Ansible e iniciar el proceso de instalación del agente Wazuh:

    ```sh
    sudo bash InstAgentLx.sh
    ```

5. El script `InstAgentLx.sh` ejecutará el playbook `instalar.yml`, que realizará la instalación del agente Wazuh en su sistema Ubuntu.

## Requisitos Previos

- **Windows**: No se requieren configuraciones previas especiales.
- **Ubuntu**:
  - Ansible debe estar instalado. Puede instalar Ansible ejecutando:

    ```sh
    sudo apt-get update
    sudo apt-get install ansible
    ```

## Notas Adicionales

- Asegúrese de que el firewall y las políticas de seguridad en su sistema permitan la instalación y el funcionamiento del agente Wazuh.
- Estos scripts están diseñados para facilitar la instalación del agente Wazuh, pero puede ser necesario ajustarlos según las configuraciones específicas de su entorno.

## Contribuciones

Las contribuciones son bienvenidas. Si encuentra algún problema o tiene alguna mejora, por favor, abra un issue o envíe un pull request.

## Licencia

Este proyecto está licenciado bajo la [Licencia MIT](LICENSE).
