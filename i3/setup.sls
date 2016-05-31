extra packages:
  pkg.installed:
    - pkgs:
      - acpi
      #- conky

i3:
  pkg.installed:
    - name: i3
  file.symlink:
    - name: /home/vagrant/.config/i3/config
    - target: /home/vagrant/etc/i3/config
    - force: True
    - makedirs: True

# Status bar for i3
i3blocks:
  pkg.installed:
    - sources:
      - i3blocks: http://mirrors.kernel.org/ubuntu/pool/universe/i/i3blocks/i3blocks_1.4-1_amd64.deb
  file.symlink:
    - name: /home/vagrant/.i3blocks.conf
    - target: /home/vagrant/etc/i3/i3blocks.conf
    - force: True

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
