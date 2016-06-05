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
    - unless: command -v volnoti
  cmd.run:
    - name: {{ salt['environ.get']('HOME') }}/etc/volnoti/install.sh
    - unless: command -v volnoti
