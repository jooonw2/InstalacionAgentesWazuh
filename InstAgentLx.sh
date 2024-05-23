#!/usr/bin/expect -f

# Configuración del tiempo de espera
set timeout -1

# Leer nombre de usuario
send_user "Nombre de usuario: "
expect_user -re "(.*)\n"
set user $expect_out(1,string)

# Leer IP
send_user "IP: "
expect_user -re "(.*)\n"
set ip $expect_out(1,string)

# Leer contraseña
send_user "Contraseña: "
stty -echo
expect_user -re "(.*)\n"
stty echo
send_user "\n"
set password $expect_out(1,string)

# Ejecutar ssh-copy-id
spawn ssh-copy-id $user@$ip
expect {
    "Are you sure you want to continue connecting (yes/no/*)?" {
        send "yes\r"
        exp_continue
    }
    "*assword" {
        send "$password\r"
        exp_continue
    }
    timeout {
        # Si hay un tiempo de espera, mostrar un mensaje de error
        puts "Error: Tiempo de espera agotado. Verifica la conexión y vuelve a intentarlo."
        exit 1
    }
    eof {
        # Capturar la salida y mostrar un mensaje de éxito o error
        set output $expect_out(buffer)
        if {[string match "*All keys were added*" $output]} {
            puts "Claves SSH copiadas correctamente a $user@$ip"

           #Exporto las variables
            set env(password) $password
            puts "Contraseña exportada como variable de entorno"

            # Conectar mediante SSH y ejecutar los comandos adicionales
            set command "sudo sed -i 's/#\?PubkeyAuthentication.*/PubkeyAuthentication yes/' /etc/ssh/sshd_config && sudo systemctl restart sshd"
            spawn ssh $user@$ip $command
            expect {
                "*assword:" {
                    send "$password\r"
                    exp_continue
                }
                eof {
                    puts "Configuración SSH modificada y servicio SSH reiniciado exitosamente."
                    exit 0
                }
                timeout {
                    puts "Error: Tiempo de espera agotado al intentar modificar la configuración SSH o reiniciar el servicio."
                    exit 1
                }
            }
        }
    }
}
exec ansible-playbook /etc/ansible/instalar.yml -i "$ip," -u "$user" --ask-become-pass
