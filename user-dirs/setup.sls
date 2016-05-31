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
    - name: /home/vagrant/.config/user-dirs.conf
    - target: /home/vagrant/etc/user-dirs/user-dirs.conf
    - force: True
    - makedirs: True
    - backupname: user-dirs.conf.old

Set /tmp to be the downloads folder and prevent default directory recreation:
  file.symlink:
    - name: /home/vagrant/.config/user-dirs.dirs
    - target: /home/vagrant/etc/user-dirs/user-dirs.dirs
    - force: True
    - makedirs: True
    - backupname: user-dirs.dirs.old

Update directory settings whenever config files change:
  pkg.installed:
    - pkgs:
      - xdg-user-dirs-gtk
  cmd.run:
    - name: xdg-user-dirs-gtk-update
    - onchanges:
      - file: /home/vagrant/.config/user-dirs.conf
      - file: /home/vagrant/.config/user-dirs.dirs
