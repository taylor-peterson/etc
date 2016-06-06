include:
  - .i3blocks.setup
  - .rofi.setup
  - .volnoti.setup

i3:
  pkg.installed:
    - name: i3
  file.symlink:
    - name: {{ salt['environ.get']('HOME') }}/.config/i3/config
    - target: {{ salt['environ.get']('HOME') }}/etc/i3/config
    - force: True
    - makedirs: True

# CLI for controlling media players over DBus
playerctl:
  pkg.installed:
    - sources:
      - playerctl: https://github.com/acrisci/playerctl/releases/download/v0.5.0/playerctl-0.5.0_amd64.deb

# Fix dunst memory-leak https://bugs.launchpad.net/ubuntu/+source/dunst/+bug/1330480
dunst:
  pkgrepo.managed:
    - ppa: cpick/dunst
  pkg.installed:
    - name: dunst
