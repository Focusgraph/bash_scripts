cd $(dirname $0)

rsync --archive --acls --xattrs --delete --progress -h --exclude-from=exclude.txt / /mnt/backup

rsync --archive --acls --xattrs --delete --progress -h --exclude-from=exclude.txt / /home/genty/Archive/Backups/agento_backup
