GREEN="\e[32m"
YELLOW="\e[33m"
ENDCOLOR="\e[0m"

BEFORE=$(df --output=source,used,size,pcent,fstype -t ext4 -t vfat -t xfs -H --total)

echo ">>> Pulling content..."

eix-sync

echo ">>> Looking for updates..."

emerge -avtquND @world

echo ">>> Cleaning packages..."

emerge -qc

echo ">>> Checking health..."

emaint cleanresume --check
emaint merges --check

echo ">>> Finishing..."

emaint cleanconfmem --fix
emaint movebin --fix
emaint moveinst --fix
emaint world --fix

echo -e "${GREEN}>>> Update completed!${ENDCOLOR}"
echo -e "${YELLOW}*** Check obsolete package entries:${ENDCOLOR}"

eix-test-obsolete -q

echo -e "${YELLOW}>>> Storage overview:${ENDCOLOR}"
echo "> Before update:

$BEFORE

> After update:
"

df --output=source,used,size,pcent,fstype -t ext4 -t vfat -t xfs -H --total
