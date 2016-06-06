# Make $HOME feel like home.

Remove undesired directories from $HOME:
  file.absent:
    - names:
      - ~/Desktop
      - ~/Documents
      - ~/Downloads
      - ~/Music
      - ~/Pictures
      - ~/Public
      - ~/Templates
      - ~/Videos
      - ~/examples.desktop

Create desired directory structure in $HOME:
  file.directory:
    - names:
      - ~/bin
      - ~/etc
      - ~/src
      - ~/tmp

Prevent Ubuntu from changing directory settings:
  file.symlink:
    - name: {{ salt['environ.get']('HOME') }}/.config/user-dirs.conf
    - target: {{ salt['environ.get']('HOME') }}/etc/user-dirs/user-dirs.conf
    - force: True
    - makedirs: True
    - backupname: user-dirs.conf.old

Set /tmp to be the downloads folder and prevent default directory recreation:
  file.symlink:
    - name: {{ salt['environ.get']('HOME') }}/.config/user-dirs.dirs
    - target: {{ salt['environ.get']('HOME') }}/etc/user-dirs/user-dirs.dirs
    - force: True
    - makedirs: True
    - backupname: user-dirs.dirs.old

Manage the user-dirs.conf file so we can trigger on changes to it:
  file.managed:
    - name: {{ salt['environ.get']('HOME') }}/etc/user-dirs/user-dirs.conf

Manage the user-dirs.dirs file so we can trigger on changes to it:
  file.managed:
    - name: {{ salt['environ.get']('HOME') }}/etc/user-dirs/user-dirs.dirs


Update directory settings whenever config files change:
  pkg.installed:
    - pkgs:
      - xdg-user-dirs-gtk
  cmd.run:
    - name: xdg-user-dirs-gtk-update
    - onchanges:
      - file: {{ salt['environ.get']('HOME') }}/etc/user-dirs/user-dirs.conf
      - file: {{ salt['environ.get']('HOME') }}/etc/user-dirs/user-dirs.dirs
