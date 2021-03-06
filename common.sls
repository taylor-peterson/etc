common-install:
  pkg.installed:
    - pkgs:
      - curl
      #- redshift
      #- shutter
      - tree
      - xbacklight
      - x11-xkb-utils # setxkbmap
      - xclip
      - zsh

common-purge:
  pkg.purged:
    - pkgs:
      - rhythmbox
      - gwibber
      - liferea
      - indicator-appmenu
