#!/usr/bin/env bash

cd "$(dirname "$0")"

flag_adopt=""

while [[ $# -gt 0 ]]; do
    case "$1" in
        -v|--verbose)
          # be verbose
          ;;
        -h|--help)
          # print help
          ;;
        --adopt)
          flag_adopt="--adopt"
          ;;
        -*)
            echo "Unknown option: '$1'" >&2
            exit 1
            ;;
        *)
            echo "Invalid argument: '$1'" >&2
            exit 1
            ;;
    esac
    shift # remove parsed option
done


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

stow --verbose --dotfiles "$flag_adopt" --target "$HOME" .
