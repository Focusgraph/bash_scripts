cd $(dirname $0)

BEFORE=$(df --output=source,used,size,pcent,fstype -t ext4 -t vfat -t xfs -H --total)

./full-backup/full-backup.sh
./sync-backup.sh

echo "Before:

$BEFORE

Now:
"

df --output=source,used,size,pcent,fstype -t ext4 -t vfat -t xfs -H --total
