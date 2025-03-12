config-file := "~/.config/nixos"

default:
  @just --list --justfile {{justfile()}}

git-add:
  git add .
update:
  nix flake update
  @just build
nixos-build:
  @just git-add
  sudo nixos-rebuild switch --show-trace --impure --flake .#nixos
update-home-manager:
  nix flake update home-manager
