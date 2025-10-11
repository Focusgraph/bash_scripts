echo ">>> Compiling kernel..."

make -j$(nproc)

echo ">>> Compiling external modules..."

emerge -q @module-rebuild

echo ">>> Installing kernel..."

make -j$(nproc) modules_install
make -j$(nproc) install
