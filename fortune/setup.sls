fortune:
  pkg.installed:
    - name: fortune-mod
  cmd.run:
    - name: make
    - cwd: {{ salt['environ.get']('HOME') }}/etc/fortune
