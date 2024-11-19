#-> Server -> vmUNO = 192.168.56.2
#-> Host -> vmDOS = 192.168.56.3


#1-> Generamos la clave 

ssh-keygen


#2-> Listamos con ll .ssh/ y verifico que se generen los archivos id_rsa y id_rsa.pub


#3-> La clave id_rsa.pub se copia y se pega en la pc host (vmDOS) con el comando de abajo:

echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC4w1Fo//sMGWSCrClzxKP6+v25x8FY0D5cBunaUuf4PKHhZXcldahrkChNsyeV/OSsCzn4RezhmrMdltzGRNOKPopUmr+NN3vU6y7Oug1fiL6+Gyjz4ZgvBy7NhhHuW1hPwyvMhfoQtlfYyHUZbU53KZRg79LeGL5A0unWoaD2WJXU0kOg4DOE3xdPhfWQH18cyKQciOh09IXB/vq3xMQxNcrJqUck2bLIY3K1ke78/xjjwM68RDcvdBUbHvxuI9DZR+iLBR+jTiA6vXv9oS/CPGrD30abkBt6FsMMfGzvqIjIJicUAZDgVFDslfC6LEasfsm7tKOU6jARD2/fX/W6Ul+052H0gcRuOlXzYJX5JSx02hf7DGd8qc26jpy9fSKXo7xgeOxWvZwSNgo3aTPoRX8rhmtVZD2K9fB3AKiwMmv7I3ZeRs3kTf5aQ5a30huYTjPVPWRJF6wpwPaUi9pMoKKmRp58V3OEvDlOkUR8aMf8Z82PoN41T7cRi0/PWcc= vagrant@vmUNO" >> .ssh/authorized.keys


#4-> En la vmUNO verifico la conexión con la vmDOS

ssh vagrant@192.168.56.3



#5->  Clono el repo de ansible para ejecutar reutilizar los archivos inventory y playbook.yml (editar archivo inventory y playbook.yml)

git clone https://github.com/upszot/UTN-FRA_SO_Ansible.git


#6-> Ejecuto el siguiente comando para que desde la vmUNO (192.168.56.2) se ejecute e instale apache en la vmDOS (192.168.56.3)

ansible-playbook -i inventory playbook.yml


#7-> En la vmDOS ejecuto el siguiente comando para verificar que se haya instalado apache

 sudo apt list --installed |grep apache

