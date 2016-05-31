python-git:
  pkg.installed:
    - name: python-git # Needs to be installed before using salt...

# TODO - instead have install steps be:
  # sudo apt-get install git
  # git clone https://github.com/taylor-peterson/etc
  # ./etc/setup

copy-etc-repo:
  git.latest:
    - name: https://github.com/taylor-peterson/etc
    - target: /home/vagrant/etc
