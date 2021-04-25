#!/bin/sh
# -*- mode: shell-script -*-
#
if ! command -v fd > /dev/null 2>&1; then
    echo "ERROR::   fd command not found."
    echo "INSTALL:: $ sudo apt install fd-find"
    echo "THEN::    $ ln -s \$(which fdfind) ~/bin/fd"
    echo "REF::     https://github.com/sharkdp/fd"
    exit
fi
#
if ! command -v cscope > /dev/null 2>&1; then
    echo "ERROR::   cscope command not found."
    echo "INSTALL:: $ sudo apt install cscopoe"
    exit
fi
#
LIST_FILE="fd-cscope.files"
DATABASE_FILE="cscope.out"
FIND="fd --ignore-case --type f"
CSCOPE="cscope"
#
echo "generating cscope file listing: ${LIST_FILE} ..."
${FIND} '\.([chly](xx|pp)*|cc|hh)$' \
    --exclude .git \
    --exclude .repo \
    --exclude .build \
    --exclude .svn \
    --exclude .hg \
    --exclude CVS \
    --exclude RCS \
    --exclude TelematicsAutomatedTest \
    --exclude int_scripts \
    --exclude tests \
    > ${LIST_FILE}
#
echo "generating cscope database: ${DATABASE_FILE} ..."
${CSCOPE} -b -c -i ${LIST_FILE} -f ${DATABASE_FILE}
#
echo "done."
