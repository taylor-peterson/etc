i3blocks script dependencies:
  pkg.installed:
    - pkgs:
      - acpi

# Status bar for i3
i3blocks:
  pkg.installed:
    - sources:
      - i3blocks: http://mirrors.kernel.org/ubuntu/pool/universe/i/i3blocks/i3blocks_1.4-1_amd64.deb
  file.symlink:
    - name: {{ salt['environ.get']('HOME') }}/.i3blocks.conf
    - target: {{ salt['environ.get']('HOME') }}/etc/i3/i3blocks/i3blocks.conf
    - force: True
