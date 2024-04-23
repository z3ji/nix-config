# nix-config

[![built with nix](https://img.shields.io/static/v1?logo=nixos&logoColor=white&label=&message=Built%20with%20Nix&color=41439a)](https://builtwithnix.org) [![built with garnix](https://img.shields.io/endpoint.svg?url=https%3A%2F%2Fgarnix.io%2Fapi%2Fbadges%2Fz3ji%2Fnix-config%3Fbranch%3Dmain)](https://garnix.io)

<!--
See an overview of the flake outputs by running: 
```
nix flake show github:z3ji/nix-config
```-->

**Highlights**:

- Various **[NixOS](https://nixos.org/download/#nixos-iso) setups**, covering both **desktop** and **laptop** environments.
- Choice of **persistency** with an emphasis on [impermanence](https://nixos.wiki/wiki/Impermanence).
- Complete **declarative** management of **self-hosted** components.
- Adaptable [**Home Manager**](https://nixos.wiki/wiki/Home_Manager) configurations utilising **feature flags**.

## Structure

- `flake.nix`: This serves as the entry point for both host and home configurations. It also provides a development shell (`nix develop` or `nix-shell`).
- `lib`: Contains several library functions aimed at improving the organisation and cleanliness of the flake.
- `hosts`: Houses NixOS Configurations, accessible through `nixos-rebuild --flake`.
  - `common`: Consists of shared configurations utilised by machine-specific configurations.
    - `global`: Contains configurations applied universally across all machines.
    - `optional`: Includes configurations that machines can opt into.
  - `desktop`: Configuration for a desktop PC equipped with a Ryzen 5 3600 and RX 5700 XT.
  - `laptop`: Configuration tailored for a MacBook Pro featuring an i7-4558U and Iris 5100.
- `home`: Manages Home-manager configuration, accessible via `home-manager --flake`.
    - Each directory represents a “feature” that can be toggled by Home-manager, allowing customisation of the setup for each machine.
- `modules`: Contains a collection of actual modules along with associated options.
<!--
## How to Install

Need help? Read the [docs](/docs/intro.md).-->