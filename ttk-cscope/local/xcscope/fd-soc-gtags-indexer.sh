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
DATABASE_FILE="cscope.out"
FIND="fd --ignore-case --type f"
CSCOPE="cscope"
GTAGS="gtags"
#
${FIND} '\.([chly](xx|pp)*|cc|hh)$' \
    VUC_APP/TVIP_Ctrl_Files/TVIP    \
    --exclude Vehicle_Micro/Middleware/IPC/src/ipc_transmit_handler_define.h \
    --exclude Vehicle_Micro/Middleware/IPC/api/ipc_if_pd_subaru.c \
    | cut -d '/' -f3- > .fdignore
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
echo "generating gtags database: ${DATABASE_FILE} ..."
${GTAGS} -v --compact -f ${LIST_FILE}
#
echo "done."
