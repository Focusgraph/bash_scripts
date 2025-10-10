echo ">>> Compiling kernel..."

make -sj16

echo ">>> Compiling external modules..."

emerge -q @module-rebuild

echo ">>> Installing kernel..."

make -s modules_install
make -s install
