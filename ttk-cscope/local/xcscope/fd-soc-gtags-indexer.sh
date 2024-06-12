#!/bin/bash
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
if ! command -v gtags > /dev/null 2>&1; then
    echo "ERROR::   gtags command not found."
    echo "INSTALL:: $ sudo apt install global"
    exit
fi
#
LIST_FILE="gtags.files"
FIND="fd --ignore-case --type f"
CSCOPE="cscope"
GTAGS="gtags"
LOG="/tmp/fd-soc-gtags-indexer.log"
#
echo "generating gtags file listing: ${LIST_FILE} ..."
${FIND} '\.([ch](xx|pp)|[ch]|cc|hh)$' \
    --exclude .git \
    --exclude .repo \
    --exclude .cache \
    --exclude .local \
    --exclude GPATH \
    --exclude GRTAGS \
    --exclude GTAGS \
    --exclude 3p \
    > ${LIST_FILE}
#
echo "generating gtags database ..."
${GTAGS} -v --compact -f ${LIST_FILE} 2>&1 | tee ${LOG}
#
echo "Done. Log output at: ${LOG}"
