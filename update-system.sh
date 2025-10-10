GREEN="\e[32m"
YELLOW="\e[33m"
ENDCOLOR="\e[0m"

echo ">>> Pulling content..."

eix-sync -a

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
echo "${YELLOW}*** Check obsolete:${ENDCOLOR}"

eix-test-obsolete -q
