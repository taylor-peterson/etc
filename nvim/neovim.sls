pkgrepo reqs:
  pkg.installed:
    - pkgs:
      - python-software-properties
      - python-pycurl
      - python-apt
      - vim # Currently need vim to setup vim-plug: https://github.com/junegunn/vim-plug/issues/225

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
    - name: /home/vagrant/.config/nvim/init.vim
    - target: /home/vagrant/etc/nvim/init.vim
    - force: True
    - backupname: inti.vim.old
    - makedirs: True

neovim-colors:
  file.symlink:
    - name: /home/vagrant/.config/nvim/colors/petetay.vim
    - target: /home/vagrant/etc/nvim/petetay.vim
    - force: True
    - makedirs: True