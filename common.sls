common-install:
  pkg.installed:
    - pkgs:
      - curl
      - git
      #- redshift
      #- shutter
      - tree
      - xbacklight
      - xclip
      - zsh

common-purge:
  pkg.purged:
    - pkgs:
      - rhythmbox
      - gwibber
      - liferea
      - indicator-appmenu
