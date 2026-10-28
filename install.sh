#!/usr/bin/env bash
mkdir -p ~/.config/hyde/themes ~/.local/share/themes
cp -r ./themes/Terra-Ink ~/.config/hyde/themes/
cp -r ./gtk-theme/Terra-Ink ~/.local/share/themes/
chmod +x ~/.config/hyde/themes/Terra-Ink/terra-engine.sh
echo "Instalado con exito. Selecciona Terra-Ink con Super+Alt+T"
