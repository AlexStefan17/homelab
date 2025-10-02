# Immich

## 1. Create dir and get compose and .env file

```
wget -O docker-compose.yml https://github.com/immich-app/immich/releases/latest/download/docker-compose.yml
wget -O .env https://github.com/immich-app/immich/releases/latest/download/example.env
```

## 2. Edit compose file and .env

```
# You can find documentation for all the supported env variables at https://immich.app/docs/install/environment-variables

# The location where your uploaded files are stored
UPLOAD_LOCATION=/mnt/nfs/immich/immich_media

# The location where your database files are stored. Network shares are not supported for the database
DB_DATA_LOCATION=/var/lib/immich/postgres

# To set a timezone, uncomment the next line and change Etc/UTC to a TZ identifier from this list: https://en.wikipedia.org/wiki/List_of_tz_database_time_zones#List
# TZ=Etc/UTC

# The Immich version to use. You can pin this to a specific version like "v1.71.0"
IMMICH_VERSION=release

# Connection secret for postgres. You should change it to a random password
# Please use only the characters `A-Za-z0-9`, without special characters or spaces
DB_PASSWORD=postgres

# The values below this line do not need to be changed
###################################################################################
DB_USERNAME=postgres
DB_DATABASE_NAME=immich
```

## 3. Mount nfs server

```
sudo mkdir -p /mnt/nfs/immich/immich_media

sudo nano /etc/fstab
172.20.50.133:/immich/immich_media /mnt/nfs/immich/immich_media nfs defaults,_netdev 0 0

sudo mount -a

sudo chown -R 999:999 /mnt/nfs/immich/immich_db
```

## 4. Run compose file

```
docker compose up -d
```
