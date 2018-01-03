pkgrepo reqs:
  pkg.installed:
    - pkgs:
      - python-software-properties
      - python-pycurl
      - python-apt

neovim:
  pkgrepo.managed:
    - ppa: neovim-ppa/unstable
  pkg.installed:
    - name: neovim
  alternatives.install:
    - name: editor
    - link: /usr/bin/editor
    - path: /usr/bin/nvim
    - priority: 100

neovim-config:
  file.symlink:
    - name: {{ salt['environ.get']('HOME') }}/.config/nvim/init.vim
    - target: {{ salt['environ.get']('HOME') }}/etc/nvim/init.vim
    - force: True
    - backupname: init.vim.old
    - makedirs: True

neovim-colors:
  file.symlink:
    - name: {{ salt['environ.get']('HOME') }}/.config/nvim/colors/petetay.vim
    - target: {{ salt['environ.get']('HOME') }}/etc/nvim/petetay.vim
    - force: True
    - makedirs: True
