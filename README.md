# My personal dotfiles

My dotfiles for MacOS/Linux, configuring my daily drivers. Powered by
[Nix](https://nix.dev/) and Home Manager, configured using the
[Dendritic](https://github.com/mightyiam/dendritic) pattern.

Configuration is found in the `modules` directory, whose files are
automatically imported depending on which user and host is active.

## How to install?

1. Clone this repo.
1. Install Nix (e.g. [Determinate Nix](https://docs.determinate.systems/).
1. `$ nix develop`
1. `$ task switch`

## Users

- `enniomara` - me@home
- `marae` - me with my work hardhat on 👷
