anki.dependencies:
  pkg.installed:
    - pkgs:
      - python-qt4

anki:
  pkg.installed:
    - sources:
      - anki: http://ankisrs.net/download/mirror/anki-2.0.33.deb
  file.symlink:
    - name: /usr/local/bin/anki
    - target: /home/vagrant/anki/anki
    - force: True
