#!/usr/bin/env bash

cd "$(dirname "$0")"

stow --verbose --dotfiles --target "$HOME" .
