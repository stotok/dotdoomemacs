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
${FIND} '\.([ch](xx|pp)|[ch]|cc|hh)$' \
    --exclude .git \
    --exclude .repo \
    --exclude .build \
    --exclude .svn \
    --exclude .hg \
    --exclude CVS \
    --exclude RCS \
    --exclude package/arm \
    --exclude package/codeaurora \
    --exclude package/conti/conti-otp-test \
    --exclude package/conti/conti-swl/test \
    --exclude package/conti/conti-tp-common/test \
    --exclude package/conti/conti-swl-ua-pers/test \
    --exclude package/conti/conti-swl-dc-ota-rb/test \
    --exclude package/conti/conti-time-mgr/test \
    --exclude package/conti/conti-debug-console/test \
    --exclude package/conti/conti-connection-mgr/test \
    --exclude package/conti/conti-libcas-hal/test \
    --exclude package/conti/conti-psapcall/src/test \
    --exclude package/conti/conti-persistence/pcl/test \
    --exclude package/conti/conti-nad/lte-test \
    --exclude package/opensource/hostap/wlantest \
    --exclude package/opensource/hostap/wpa_supplicant \
    --exclude package/opensource/dbus/test \
    --exclude package/opensource/sudo \
    --exclude package/opensource/mtd-utils \
    --exclude package/opensource/openssl \
    --exclude package/opensource/c-ares \
    --exclude package/opensource/curl/tests \
    --exclude package/opensource/kmod \
    --exclude package/opensource/linux-pam \
    --exclude package/opensource/lzo \
    --exclude package/opensource/ethtool \
    --exclude package/opensource/glib/tests \
    --exclude package/opensource/pugixml \
    --exclude package/opensource/linux/sound \
    --exclude package/opensource/libatomic_ops \
    --exclude package/opensource/libarchive \
    --exclude package/opensource/libxml2 \
    --exclude package/opensource/lttng-modules \
    --exclude package/opensource/lttng-tools \
    --exclude package/opensource/libnetfilter_conntrack \
    --exclude package/opensource/binutils/gdb \
    --exclude package/opensource/gdb \
    --exclude package/opensource/userspace-rcu \
    --exclude package/opensource/iptables \
    --exclude package/opensource/ncurses \
    --exclude package/opensource/ntp \
    --exclude package/opensource/libvorbis \
    --exclude package/opensource/libpcap \
    --exclude package/opensource/ppp \
    --exclude package/opensource/sqlite \
    --exclude package/opensource/json-glib \
    --exclude package/opensource/linux/lib/raid6 \
    --exclude package/opensource/linux/drivers/gpu \
    --exclude package/opensource/linux/drivers/usb/gadget/function \
    --exclude package/opensource/linux/drivers/media \
    --exclude package/opensource/linux/arch/alpha \
    --exclude package/opensource/linux/arch/arc \
    --exclude package/opensource/linux/arch/arm64 \
    --exclude package/opensource/linux/arch/avr32 \
    --exclude package/opensource/linux/arch/blackfin \
    --exclude package/opensource/linux/arch/c6x \
    --exclude package/opensource/linux/arch/cris \
    --exclude package/opensource/linux/arch/frv \
    --exclude package/opensource/linux/arch/hexagon \
    --exclude package/opensource/linux/arch/ia64 \
    --exclude package/opensource/linux/arch/m32r \
    --exclude package/opensource/linux/arch/m68k \
    --exclude package/opensource/linux/arch/metag \
    --exclude package/opensource/linux/arch/microblaze \
    --exclude package/opensource/linux/arch/mips \
    --exclude package/opensource/linux/arch/mn10300 \
    --exclude package/opensource/linux/arch/openrisc \
    --exclude package/opensource/linux/arch/parisc \
    --exclude package/opensource/linux/arch/powerpc \
    --exclude package/opensource/linux/arch/s390 \
    --exclude package/opensource/linux/arch/score \
    --exclude package/opensource/linux/arch/sh \
    --exclude package/opensource/linux/arch/sparc \
    --exclude package/opensource/linux/arch/tile \
    --exclude package/opensource/linux/arch/um \
    --exclude package/opensource/linux/arch/unicore32 \
    --exclude package/opensource/linux/arch/x86 \
    --exclude package/opensource/linux/arch/xtensa \
    --exclude package/opensource/zlib \
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
