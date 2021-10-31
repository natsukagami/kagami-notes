---
title: Moving my DigitalOcean node to Nix (Chapter 1...)
date: 2021-10-31T22:00:00
draft: false
---

Lately I have been switching my primary Linux PC from Arch Linux to [NixOS](https://nixos.org), a Linux distribution with a functional twist: completely stateless configuration. It's been quite a pleasant ride, and Nix the expression language, though a bit lacking in friendly documentation, is actually not that hard to get used to (... but the `nixpkgs.lib` functions are **not**!)

With the help of [`home-manager`](https://github.com/nix-community/home-manager), a Nix module/program that manages user-specific configuation in the same Nix language, I have a completely working `.config` with all the relevant programs installed ([kak](https://kakoune.org) editor, fish with my bindings, ...) completely synchronized between my M1 MacBook Air and the Linux PC. 

Of course, to expand the reach of Nix, I decided to move my DigitalOcean node, where I run my Discord bots, a personal email server, a git server and a small photo store, to NixOS as well.

## What are the goals of a remote NixOS configuration?

- Well, for a starter, it should be able to run all the stuff I have been running. 
  This is actually not trivial. I run most of my stuff on the old DigitalOcean node as a bunch of Docker Compose containers, each with their own `docker-compose.yml` file (but sharing the same reverse proxy and PostgreSQL database!)
  However with NixOS I want all of them to run "bare-metal" on the system, where I can declaratively update them at will and not through a hacked-up `docker-compose` wrapper.
- The configuration process should be done remotely and preferrably automated.
  Right now my deploy tool of choice is [`deploy-rs`](https://github.com/Serokell/deploy-rs), which I have chosen for its native Nix Flakes support and seemingly careful deployment process. Also, the project is used internally by Serokell, who is also basing their business off of the growth of Nix ecosystem; which means, this project should be maintained well for the foreseeable future! 
  However I have a small gripe that it requires evaluating the Nix configuration of the remote machine on the local machine, which I cannot do from my MacBook because of different environment (`aarch64-darwin` vs `x86_64-linux`). 

And... that should be good for now! I am still in the process of setting things up. Expect follow up posts in the future! 

You can find my entire configuration tree on [`nix-home`](https://github.com/natsukagami/nix-home) (which will be public soon, I promise...!)

