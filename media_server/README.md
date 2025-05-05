# Media Server

## 1. Create ZFS Pool
- 2x 1TB HDDs RAID 1

## 2. Create LXC container 
### Specs
- 2 GiB RAM
- 1 GiB Swap
- 64 GiB disk

### Configs
- mount ZFS storage:
```
mp0: hdds:subvol-201-disk-0,mp=/data,size=4000G
```

- create new user:
```
adduser alex
```
```
adduser alex sudo
```
```
sudo chown -R alex:alex /data
```

- samba

```
sudo apt install samba -y
```

```
cd /etc/samba
```

```
sudo mv smb.conf smb.conf.old
```

- create samba config
```
vim /etc/samba/smb.conf
```

```
[global]
   server string = Media
   workgroup = WORKGROUP
   security = user
   map to guest = Never
   name resolve order = bcast host
   hosts allow = 192.168.1.0/24
   hosts deny = 0.0.0.0/0
[data]
   path = /data
   force user = alex
   force group = alex
   create mask = 0774
   force create mode = 0774
   directory mask = 0775
   force directory mode = 0775
   browseable = yes
   writable = yes
   read only = no
   guest ok = no
```

```
sudo smbpasswd -a brandon
```

```
sudo systemctl enable smbd
sudo systemctl enable nmbd
sudo systemctl restart smbd
sudo systemctl restart nmbd
```

- Install wsdd for Windows discorvery
```
sudo apt install wsdd
```

## 3. Debian VM for media services:
### Specs
- 4 GiB RAM
- 4 CPU cores
- 32 GB disk

### Configs
- install docker
- add samba


```
sudo mount -t cifs //192.168.1.145/data /mnt/samba_share -o username=alex,password=<password>,uid=1000,gid=1000,file_mode=0775,dir_mode=0775
```

- in /etc/fstab add this:
```
 //192.168.1.145/data /mnt/samba_share cifs username=alex,password=,uid=1000,gid=1000,file_mode=0775,dir_mode=0775 0 0
```

## 4.Start docker containers
- add docker compose file and start the containers
```
docker composer up -d
```

## 5. LXC for jellyfin
- https://community-scripts.github.io/ProxmoxVE/scripts?id=jellyfin
- run this command on proxmox host

```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/community-scripts/ProxmoxVE/main/ct/jellyfin.sh)"
```
