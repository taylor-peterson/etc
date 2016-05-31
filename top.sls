# This does everything necessary to provision a box for
# personal development work - work machines require a
# bit more love.
#
# The first line is the ID for the set of data.
# -> it sets the name of the things that needs to be manipulated.

base:
  '*':
    - common
    - user-dirs
    - neovim
    - etc
    - i3
    - chrome
    - spotify
  '*home*':
    - skype
