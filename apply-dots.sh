#!/usr/bin/env bash

cd "$(dirname "$0")"

case "$XDG_CURRENT_DESKTOP" in
    GNOME)
      ln -sf -T "$(realpath "dot-config/alacritty/gnome.toml"  )"  "dot-config/alacritty/alacritty.toml"
        ;;
    KDE)
      ln -sf -T "$(realpath "dot-config/alacritty/kde.toml"  )"  "dot-config/alacritty/alacritty.toml"
        ;;
    *)
        ;;
esac

stow --verbose --dotfiles --target "$HOME" .
