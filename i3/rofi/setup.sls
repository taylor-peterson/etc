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
      - libharfbuzz0b
      - libharfbuzz-dev
      - libpango1.0-dev
      - libpangocairo-1.0-0
      - librsvg2-dev
     # - check - 0.11 not on 14.04
      - libstartup-notification0-dev
      - libx11-6
      - libxcb-ewmh-dev
      - libxcb-icccm4-dev
      - libxcb-xinerama0-dev
      - libxcb-randr0-dev
      # also need libxcb-xrm-dev, which isn't available on 14.04 - need to build from source
      - libxcb-xkb-dev
      - libxcb1
      - libglib2.0-0
      - libglib2.0-dev
      - libxcb-util0-dev
      - libxkbcommon-x11-dev
      - libx11-xcb-dev
      - flex # may need to get from backports repo on 14.04
      - bison
  git.latest:
    - name: https://github.com/DaveDavenport/rofi
    - target: /tmp/rofi
    - unless: command -v rofi
  cmd.run:
    - name: {{ salt['environ.get']('HOME') }}/etc/i3/rofi/install.sh
    - unless: command -v rofi
  file.symlink:
    - name: {{ salt['environ.get']('HOME') }}/.config/i3/rofi/config
    - target: {{ salt['environ.get']('HOME') }}/etc/i3/rofi/config
    - force: True
    - makedirs: True
