fortune:
  pkg.installed:
    - name: fortune-mod
  file.managed:
    - name: {{ salt['environ.get']('HOME') }}/etc/conky/fortune/fortune
    - replace: False
  cmd.run:
    - name: make
    - cwd: {{ salt['environ.get']('HOME') }}/etc/conky/fortune
    - onchanges:
      - file: {{ salt['environ.get']('HOME') }}/etc/conky/fortune/fortune
