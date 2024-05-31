 # Scripts de Automatización para la Implementación de Clientes Wazuh

Este repositorio contiene scripts diseñados para automatizar la implementación de los clientes de Wazuh en sistemas operativos Windows y Linux (remotamente). A continuación, se detalla el uso y funcionamiento de cada uno de los archivos incluidos.
En los dos scripts se debera expecificar la IP donde se encuentre instalado el servidor wazuh.

## Contenido del Repositorio

- **InstAgentWin.bat**: Script para la instalación del agente Wazuh en sistemas Windows. Se deberá ejecutar en la maquina Windows donde se quiera instalar.
- **InstAgentLx.sh**: Script de shell para la instalacion del agente Wazuh en sistemas Ubuntu. Se deberá ejecutar en el servidor donde se encuentre Wazuh Server. No necesitaremos tener acceso al cliente donde se quiere instalar.
- **instalar.yml**: Playbook de Ansible necesario para la instalación del agente Wazuh en sistemas Ubuntu. Este archivo debe estar ubicado en la carpeta de Ansible del servidor.

## Instrucciones de Uso

### Instalación en Windows

1. Clone este repositorio en la máquina Windows donde desea instalar el cliente Wazuh.
2. Ejecute el archivo `InstAgentWin.bat` haciendo doble clic en él o desde una ventana de comandos con privilegios de administrador:

    ```sh
    InstAgentWin.bat
    ```

   Este script descargará e instalará automáticamente el agente Wazuh en su sistema Windows.
   Si lo queremos verificar podemos ver si se nos ha añadido y arrancado el servicio wazuh.

### Instalación en Ubuntu

1. Clone este repositorio en el servidor donde se encuentre Wazuh server.
2. Asegúrese de tener Ansible instalado y configurado en su sistema.
3. Navegue hasta el directorio del repositorio clonado. Guarda el paylook(instalar.yml) en la carpeta de ansible.
4. Ejecute el script `InstAgentLx.sh` para iniciar el proceso de instalación del agente Wazuh. Le pedira usuario, contraseña e IP de la maquina donde quiere instalar el wazuh agente.

    ```sh
    sudo bash InstAgentLx.sh
    ```

6. El script `InstAgentLx.sh` ejecutará el playbook `instalar.yml`, que realizará remotamente la instalación del agente Wazuh en su sistema Ubuntu.

## Requisitos Previos

- **Windows**: No se requieren configuraciones previas especiales.
- **Ubuntu**(Todo en el servidor, en el cliente donde se hara todo remoto lo unico que necesitamos es que este instalado openssh):
  - Debemos tener instalado expect
    ```sh
    sudo apt-get update
    sudo apt-get install expect
    ```
  - Ansible debe estar instalado y configurado. Puede instalar Ansible y configurarlo ejecutando:
    ```sh
    sudo apt-add-repository ppa:ansible/ansible
    sudo apt-get install ansible
    sudo apt install python3-argcomplete
    sudo activate-global-python-argcomplete3
    ```
  - Deberemos configurar tambien las claves ssh del servidor:
    ```sh
    ssh-keygen -t rsa -b 4096 -C "Ansible Key"
    ```
  - Debemos añadir un usuario al servidor y configurarlo para que se pueda ejecutar sin contraseña:
    ```sh
    sudo adduser ansible
    echo "ansible ALL=(ALL) NOPASSWD" | sudo tee /etc/sudoers.d/ansible
    sudo usermod -L ansible
    ```
## Notas Adicionales

- Asegúrese de que el firewall y las políticas de seguridad en su sistema permitan la instalación y el funcionamiento del agente Wazuh.
- Estos scripts están diseñados para facilitar la instalación del agente Wazuh, pero puede ser necesario ajustarlos según las configuraciones específicas de su entorno.

## Contribuciones

Las contribuciones son bienvenidas. Si encuentra algún problema o tiene alguna mejora, por favor, abra un issue o envíe un pull request.
