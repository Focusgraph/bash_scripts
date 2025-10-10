echo ">>> Compiling kernel..."

make -j16

echo ">>> Compiling external modules..."

emerge -q @module-rebuild

echo ">>> Installing kernel..."

make modules_install
make install
