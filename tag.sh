#!/bin/sh
# generate tag file for lookupfile plugin
echo -e "!_TAG_FILE_SORTED\t2\t/2=foldcase/" > filenametags
find . -path '*/.svn' -prune -o -path '*/.git' -prune -o -not -regex '.*\.\(png\|gif\|swp\|db\)' -type f -print | sort -f >> filenametags
