#!/usr/bin/env bash

apply_terra() {
    # Si cambiamos a otro tema, limpiar el bloque de style.css y salir sin afectar otros temas
    if ! grep -q 'Terra-Ink' ~/.config/hypr/themes/theme.conf 2>/dev/null; then
        sed -i '/\/\* === TERRA-INK BAD-BLOOD EDITION START === \*\//,/\/\* === TERRA-INK BAD-BLOOD EDITION END === \*\//d' ~/.config/waybar/style.css 2>/dev/null
        exit 0
    fi

    # 1. Aplicar tema GTK propio aislado
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
    gsettings set org.gnome.desktop.interface gtk-theme 'Terra-Ink'

    # 2. Aplicar Rofi
    sed '1d' ~/.config/hyde/themes/Terra-Ink/rofi.theme > ~/.config/rofi/theme.rasi

    # 3. Aplicar Waybar en theme.css Y al final de style.css para máxima prioridad visual
    sed '1d' ~/.config/hyde/themes/Terra-Ink/waybar.theme > ~/.config/waybar/theme.css
    sed -i '/\/\* === TERRA-INK BAD-BLOOD EDITION START === \*\//,/\/\* === TERRA-INK BAD-BLOOD EDITION END === \*\//d' ~/.config/waybar/style.css 2>/dev/null
    sed -n '/\/\* === TERRA-INK BAD-BLOOD EDITION START === \*\//,/\/\* === TERRA-INK BAD-BLOOD EDITION END === \*\//p' ~/.config/hyde/themes/Terra-Ink/waybar.theme >> ~/.config/waybar/style.css
    killall -SIGUSR2 waybar 2>/dev/null

    # 4. Aplicar Kvantum para Dolphin
    if [ -d ~/.config/Kvantum/Wallbash ]; then
        sed '1d' ~/.config/hyde/themes/Terra-Ink/kvantum.theme > ~/.config/Kvantum/Wallbash/Wallbash.kvconfig
    fi

    # 5. Estilizar notificaciones Dunst
    for dconf in ~/.config/dunst/dunst.conf ~/.cache/hyde/wallbash/dunst.conf; do
        if [ -f "$dconf" ]; then
            sed -i 's/background = .*/background = "#110C0Ae6"/g' "$dconf"
            sed -i 's/foreground = .*/foreground = "#EDE0CEff"/g' "$dconf"
            sed -i 's/frame_color = .*/frame_color = "#C44D41ff"/g' "$dconf"
        fi
    done
    killall dunst 2>/dev/null
}

apply_terra
(sleep 1.2 && apply_terra) &
