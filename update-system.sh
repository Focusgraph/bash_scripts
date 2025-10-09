echo "Pulling content..."

emerge --sync

echo "Searching updates..."

emerge -avtuND @world
