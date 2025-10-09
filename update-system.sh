echo ">>> Pulling content..."

emaint sync -a

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

echo ">>> Update completed!"
echo "*** Check obsolete:"

eix-test-obsolete -q
