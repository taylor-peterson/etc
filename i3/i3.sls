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

# Notification daemon for volume and brightness
volnoti:
  pkg.installed:
    - pkgs:
      - libdbus-1-dev
      - libdbus-glib-1-2
      - libdbus-glib-1-dev
      - libglib2.0-dev
      - libglib2.0-0
      - libglib2.0-bin
      - pkg-config
      - libgtk2.0-dev
  git.latest:
    - name: https://github.com/davidbrazdil/volnoti
    - target: /tmp/volnoti
    - unless: volnoti -h
  cmd.run:
    - cwd: /tmp/volnoti
    - name: |
        ./prepare.sh
        ./configure --prefix=/usr
        # Fix compilation error. See http://ubuntuforums.org/showthread.php?t=2215264
        cd src
        rm value-client-stub.h && make value-client-stub.h
        rm value-daemon-stub.h && make value-daemon-stub.h
        cd -
        make
        sudo make install
    - unless: volnoti -h

rofi versioned dependencies:
  pkg.installed:
    - sources:
      - libxkbcommon-dev: http://launchpadlibrarian.net/212081715/libxkbcommon-dev_0.5.0-1ubuntu2_amd64.deb
      - libxkbcommon0: http://launchpadlibrarian.net/212081719/libxkbcommon0_0.5.0-1ubuntu2_amd64.deb
rofi:
  pkg.installed:
    - pkgs:
      - libc6
      - libcairo2
      - libpango-1.0-0
      - libpangocairo-1.0-0
      - libstartup-notification0-dev
      - libx11-6
      - libxcb-ewmh-dev
      - libxcb-icccm4
      - libxcb-xinerama0
      - libxcb-xkb-dev
      - libxcb1
      - libglib2.0-0
      - libxcb-util0-dev
      - libxkbcommon-x11-dev
      - libx11-xcb-dev
  git.latest:
    - name: https://github.com/DaveDavenport/rofi
    - target: /tmp/rofi
    - unless: command -v rofi
  cmd.run:
    - cwd: /tmp/rofi
    - name: |
        git submodule update --init
        autoreconf -i
        mkdir build
        cd build
        ../configure
        make
        sudo make install
    - unless: command -v rofi
  file.symlink:
    - name: /home/vagrant/.config/rofi/config
    - target: /home/vagrant/etc/rofi/config
    - force: True
    - makedirs: True
