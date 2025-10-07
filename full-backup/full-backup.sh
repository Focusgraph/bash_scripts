cd $(dirname $0)

rsync --archive --acls --xattrs --delete --progress --verbose --exclude-from=exclude.txt / /mnt/backup

rsync --archive --acls --xattrs --delete --progress --verbose --exclude-from=exclude.txt / /home/genty/Archive/Backups/agento_backup
