# This does everything necessary to provision a box for
# personal development work - work machines require a
# bit more love.
#
# Everything that needs configuration on a new machine
# should get a folder with any configuration information
# and a setup.sls file.

base:
  '*':
    - common
    - etc
    - user-dirs.setup
    - nvim.setup
    - chrome.setup
    - spotify.setup
    - i3.setup
    - rofi.setup
    - volnoti.setup
  '*home*':
    - skype
