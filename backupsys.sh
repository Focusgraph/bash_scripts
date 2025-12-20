cd $(dirname $0)

if [[ ! -f ~/bash_scripts/config/backupsys.conf ]]
then
	echo "Configuration file not found, you can find a sample at 'config' directory"
	exit 2
fi

source config/backupsys.conf

RED="\e[31m"
YELLOW="\e[33m"
GREEN="\e[32m"
ENDCOLOR="\e[0m"

# Check for mounted drive
if [[ -d $BACKUP_DIRECTORY ]]
then
    echo -e "${GREEN}*** Backup drive mounted ${ENDCOLOR}"
else
    echo -e "${YELLOW}!!! Backup drive not mounted ${ENDCOLOR}"
    echo -e "${YELLOW}!!! Skipping backup ${ENDCOLOR}"
    exit 2
fi

# System backup
echo -e "${GREEN}>>> Backing up system...${ENDCOLOR}"
restic -p $PASSWORD -r $BACKUP_DIRECTORY --exclude-file $EXCLUDE backup /

restic forget -q -p $PASSWORD --prune --keep-daily 3 --keep-last 5 -r $BACKUP_DIRECTORY
