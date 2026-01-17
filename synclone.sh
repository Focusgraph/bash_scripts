cd $(dirname $0)

SOURCE=~
REMOTE=btarch
TARGET_DIR=/mnt/home_server/Backups
TARGET="$REMOTE:$TARGET_DIR"

if [[ -n $1 ]] then
    SOURCE=$1

    if [[ -n $2 ]] then
        TARGET=$2
    fi

    echo "Backing up: $1 --> $TARGET"
else
    echo "Backing up: $(echo $SOURCE) --> $TARGET"
fi

# while getopts ":abc" opt; do
# case ${opt} in
#     d)
#         echo "Delete trigger"
#         ;;
# esac
# done

rsync -Pavh --exclude-from=config/rsync_exclude.txt $SOURCE $TARGET

echo "Source size >> $(du -sh $SOURCE)"
echo "Remote size >> $(ssh $REMOTE du -sh $TARGET_DIR)"
