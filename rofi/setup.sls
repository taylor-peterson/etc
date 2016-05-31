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
    - name: /home/vagrant/etc/rofi/install.sh
    - unless: command -v rofi
  file.symlink:
    - name: /home/vagrant/.config/rofi/config
    - target: /home/vagrant/etc/rofi/config
    - force: True
    - makedirs: True
