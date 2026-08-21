#!/usr/bin/env bash

cd "$(dirname "$0")"

stow --simulate --verbose --dotfiles --target "$HOME" .
