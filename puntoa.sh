#1-> Creamos las particiones de discos, 3 primarias y 1 extendida

sudo fdisk /dev/sdc

# Creación de las particiones primarias (3 en total)
n new
p partition
enter
enter
+1G

# Creación de las particiones extendidas
new
e extended
enter
enter
+3G

# Creación 2 particiones lógicas dentro de extendida, hacer esto x2
n new
enter
+1G

#2-> La partición extendida la modificamos a SWAP

sudo mkswap /dev/sdc

t cambiar el sistema de archivos
1 elegimos partición 1
L listado de fs
82 elige fs swap
w guardamos

#3-> Ejecutamos los siguientes comandos para finalizar con los archivos SWAP

t cambiar el sistema de archivos
1 elegimos partición 1
L listado de fs
82 elige fs swap
w guardar 

#LUEGO 

sudo mkswap /dev/sdc1 # Destinamos la particos 1 como SWAP
sudo swapon /dev/sdc1 # Habilita la memoria SWAP

#5-> Modificamos el sistema de archivos para los sdc2, sdc3, sdc5, y sdc6 

sudo fdisk /dev/sdc
t modificamos el sistema de archivos
elegimos partición 2
L listado de fs
8e elige fs linux lvm
w guardar 


#6-> Crea los volúmenes lógicos

sudo pvcreate /dev/sdc2 /dev/sdc3 /dev/sdc5 /dev/sdc6 


# crea los grupos vgAdmin y lo asigna a los sdc2 y sdc3

sudo vgcreate vgAdmin /dev/sdc2 /dev/sdc3 

#7-> Creamos las LVM

sudo lvcreate -L 1G vgDevelopers -n lvDevelopers
sudo lvcreate -L 1G vgDevelopers -n lvTesters
sudo lvcreate -L .9G vgDevelopers -n lvDevops
sudo lvcreate -L 2G vgAdmin -n lvAdmin

#8-> Fromateamos las LVM

sudo mkfs.ext4 /dev/mapper/vgAdmin-lvAdmin
sudo mkfs.ext4 /dev/mapper/vgDevelopers-lvDevelopers
sudo mkfs.ext4 /dev/mapper/vgDevelopers-lvTesters
sudo mkfs.ext4  /dev/mapper/vgDevelopers-lvDevops

#9-> Montamos las LVM

sudo mkdir /mnt/lvDevelopers
sudo mkdir /mnt/lvTesters
sudo mkdir /mnt/lvDevops
sudo mkdir /mnt/lvAdmin

sudo mount /dev/mapper/vgDevelopers-lvDevelopers /mnt/lvDevelopers
sudo mount /dev/mapper/vgDevelopers-lvTesters /mnt/lvTesters
sudo mount /dev/mapper/vgDevelopers-lvDevops /mnt/lvDevops
sudo mount /dev/mapper/vgAdmin-lvAdmin /mnt/lvAdmin



