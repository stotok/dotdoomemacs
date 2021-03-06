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
FIND="fd -L --ignore-case --type f" # -L: follow symlink (for PD source code: package/external)
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
    --exclude package/arm \
    --exclude package/codeaurora \
    --exclude package/opensource \
    --exclude package/valens \
    --exclude package/specs \
    --exclude package/qualcomm \
    --exclude tools \
    --exclude release-toolchain \
    --exclude release-host \
    --exclude release \
    --exclude project \
    --exclude platform-hal \
    --exclude platform-framework \
    --exclude platform \
    --exclude logs \
    --exclude package/external/conti-dcm/code/test_code \
    --exclude package/external/conti-dcm/code/tools \
    --exclude package/external/conti-dcm/code/stub \
    > ${LIST_FILE}
#
echo "generating cscope database: ${DATABASE_FILE} ..."
${CSCOPE} -b -c -i ${LIST_FILE} -f ${DATABASE_FILE}
#
echo "done."
