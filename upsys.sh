cd $(dirname $0)

GREEN="\e[32m"
YELLOW="\e[33m"
ENDCOLOR="\e[0m"

BEFORE=$(df --output=source,used,size,pcent,fstype -t ext4 -t vfat -t xfs -H --total)

echo ">>> Pre-backup..."

./backupsys

emerge --moo

echo ">>> Preparing..."

rm -rvf /var/tmp/portage/* /var/cache/edb/*

echo ">>> Syncing content..."

eix-sync

echo ">>> Looking for updates..."

emerge -avuND @world

if [[ $(echo $?) != 0 ]]
then
	echo -e "${YELLOW}*** Update halted!"
	exit 1
fi

smart-live-rebuild -q

echo ">>> Cleaning..."

./cleansys

echo ">>> Post-backup..."

./backupsys

echo ">>> Deduplicating..."

duperemove -rdh --hashfile=config/update.hash /usr /opt


echo -e "${YELLOW}*** Check entries:${ENDCOLOR}"

eix-test-obsolete -q
emaint merges --check
glsa-check -t affected

echo -e "${YELLOW}>>> Storage overview:${ENDCOLOR}"
echo "> Before update:

$BEFORE

> After update:
"

df --output=source,used,size,pcent,fstype -t ext4 -t vfat -t xfs -H --total

echo -e "${GREEN}>>> Update completed${ENDCOLOR}"
