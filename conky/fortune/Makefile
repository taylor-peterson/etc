# This Makefile generates all .dat files required for random quote access.
# All files not excluded by IGNORE_SPECIAL_FILES are assumed to be fortune files.

SHELL = /bin/sh

LIST_ALL_FILES = ls -1
IGNORE_SPECIAL_FILES = egrep -v '\.dat|README|Makefile'
APPEND_DAT_TO_EACH = sed -e 's/$$/.dat/g'

REQUIRED_DAT_FILES += $(shell $(LIST_ALL_FILES) | $(IGNORE_SPECIAL_FILES) | $(APPEND_DAT_TO_EACH) )

$(REQUIRED_DAT_FILES) : %.dat : %
	strfile $< $@

.PHONY : clean
clean:
	-rm -f *.dat
