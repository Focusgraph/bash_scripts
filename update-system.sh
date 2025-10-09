echo ">>> Pulling content..."

emaint sync -a

echo ">>> Looking for updates..."

emerge -avtquND @world

echo ">>> Cleaning packages..."

emerge -qc

echo ">>> Update completed!"
