rbenv-deps:
  pkg.installed:
    - names:
      - bash
      - git
      - openssl
      - libssl-dev
      - make
      - curl
      - autoconf
      - bison
      - build-essential
      - libffi-dev
      - libyaml-dev
      - libreadline6-dev
      - zlib1g-dev
      - libncurses5-dev

ruby-2.1.3:
  rbenv.installed:
    - default: True
    - require:
      - pkg: rbenv-deps

travis:
  gem.installed
