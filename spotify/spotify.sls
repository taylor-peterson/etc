spotify.repo:
  pkgrepo.managed:
    - humanname: spotify
    - name: deb http://repository.spotify.com stable non-free
    - file: /etc/apt/sources.list.d/spotify.list
    - keyid: BBEBDCB318AD50EC6865090613B00F1FD2C19886
    - keyserver: hkp://keyserver.ubuntu.com:80

spotify-client:
  pkg.installed
