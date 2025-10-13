#eclean-kernel -s mtime -A -n 1

cd $(dirname $0)

GREEN="\e[32m"
YELLOW="\e[33m"
ENDCOLOR="\e[0m"

BEFORE=$(df --output=source,used,size,pcent,fstype -t ext4 -t vfat -t xfs -H --total)

echo ">>> Pre-backup..."
echo 'TIME="0"' >backup/backup_time

./backup/backup.sh

emerge --moo

echo ">>> Preparing..."

rm -rf /var/tmp/portage/*

echo ">>> Pulling content..."

eix-sync

echo ">>> Looking for updates..."

emerge -avtquND @world

echo "*** Do you wish to continue?"

select yn in "Yes" "No"; do
	case $yn in
		Yes ) break;;
		No ) exit;;
	esac
done

smart-live-rebuild -q

echo ">>> Cleaning..."

emerge -aqc
eclean-dist && eclean-pkg
eclean-dist -di && eclean-pkg -di

echo ">>> Checking health..."

#CHECK_HEALTH0=$(emaint cleanresume --check)
CHECK_HEALTH1=$(emaint merges --check)

echo ">>> Finishing..."

emaint cleanconfmem --fix
emaint movebin --fix
emaint moveinst --fix
emaint world --fix

echo ">>> Post-backup..."
echo 'TIME="1"' >backup/backup_time

./backup/backup.sh

echo ">>> Deduping..."

duperemove -rdqh --hashfile=/home/genty/update.hash /usr/src/ /mnt/backup/ /home/genty/Archive/Backups/agento_backup/

echo -e "${GREEN}>>> Update completed!${ENDCOLOR}"
echo -e "${YELLOW}*** Check entries:${ENDCOLOR}"

eix-test-obsolete -q
#$CHECK_HEALTH0
$CHECK_HEALTH1

echo -e "${YELLOW}>>> Storage overview:${ENDCOLOR}"
echo "> Before update:

$BEFORE

> After update:
"

df --output=source,used,size,pcent,fstype -t ext4 -t vfat -t xfs -H --total
