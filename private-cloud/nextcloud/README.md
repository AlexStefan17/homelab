# Nextcloud

## 1. Mount nfs server

```
sudo mkdir -p /mnt/nfs/nextcloud
sudo mount 172.20.50.133:/nextcloud /mnt/nfs/nextcloud
sudo nano /etc/fstab
172.20.50.133:/nextcloud /mnt/nfs/nextcloudnfs defaults,_netdev 0 0
sudo mount -a
```

## 2. Edit .env file

```
# ===== Nextcloud =====
NEXTCLOUD_ADMIN_USER=admin
NEXTCLOUD_ADMIN_PASSWORD=password
NEXTCLOUD_TRUSTED_DOMAINS=nextcloud.local.com

# ===== Database =====
MYSQL_ROOT_PASSWORD=rootpassword
MYSQL_DATABASE=nextcloud
MYSQL_USER=nextclouduser
MYSQL_PASSWORD=dbpassword

# ===== Paths =====
NEXTCLOUD_DATA=/mnt/nfs/nextcloud_data
```

## 3. Run compose file

```
docker compose up -d
```
