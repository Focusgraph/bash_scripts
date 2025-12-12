cd $(dirname $0)

source config/backupsys.conf

restic snapshots -p $PASSWORD -r $SYS_BACKUP_DIRECTORY
