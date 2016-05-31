chrome.repo:
  pkgrepo.managed:
    - humanname: Google Chrome
    - name: deb http://dl.google.com/linux/chrome/deb/ stable main
    - dist: stable
    - require_in:
      - pkg: google-chrome-stable
    - file: /etc/apt/sources.list.d/google-chrome.list
    - key_url: https://dl-ssl.google.com/linux/linux_signing_key.pub

google-chrome-stable:
  pkg.installed

x-www-browser:
  alternatives.install:
    - link: /usr/bin/x-www-browser
    - path: /usr/bin/google-chrome-stable
    - priority: 100

gnome-www-browser:
  alternatives.install:
    - link: /usr/bin/gnome-www-browser
    - path: /usr/bin/google-chrome-stable
    - priority: 100
