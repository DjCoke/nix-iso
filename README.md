# ex-nixos-live-iso

An example of how to create a custom NixOS live CD/ISO with nix flakes.

Build the ISO with:

```sh
$ nix build .#iso
```

The resulting ISO will be in `./result/iso/`
