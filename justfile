config-file := "~/.config/nixos"

default:
  @just --list --justfile {{justfile()}}

git-add:
  git add .

nixos-update:
  nix flake update
  @just nixos-build

nixos-build:
  @just git-add
  sudo nixos-rebuild switch --show-trace --impure --flake .#nixos

[positional-arguments]
[working-directory: "secrets"]
edit-secret file:
  EDITOR=vi nix run github:ryantm/agenix -- -e $1

update-home-manager:
  nix flake update home-manager
