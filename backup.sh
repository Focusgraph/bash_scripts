cd $(dirname $0)

BEFORE=$(df --total -h)

./full-backup/full-backup.sh
./sync-backup.sh

echo "Before:

$BEFORE

Now:
"

df --total -h
