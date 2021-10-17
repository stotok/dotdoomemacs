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
${FIND} '\.([chly](xx|pp)*|cc|hh)$' \
    VUC_APP/TVIP_Ctrl_Files/TVIP | cut -d '/' -f3- > .fdignore
#
echo "generating cscope file listing: ${LIST_FILE} ..."
${FIND} '\.([ch](xx|pp)|[ch]|cc|hh)$' \
    --exclude .git \
    --exclude .repo \
    --exclude Int_Scripts \
    --exclude PRJ_CMN/.git \
    --exclude TelematicsAutomatedTest/TraceKeywords/.git \
    --exclude TelematicsAutomatedTest/TraceKeywords/.doc \
    --exclude TelematicsAutomatedTest/TraceKeywords/tools \
    --exclude TelematicsAutomatedTest/ \
    --exclude tests \
    --exclude TVIP/.git \
    --exclude TVIP/ATP_suites \
    --exclude TVIP/Vehicle_Micro/.settings \
    --exclude TVIP/Vehicle_Micro/Application \
    --exclude TVIP/Vehicle_Micro/Application_PTF \
    --exclude TVIP/Vehicle_Micro/User_Config \
    --exclude TVIP/Vehicle_Micro/User_Config_PTF \
    --exclude TVIP/Vehicle_Micro/target \
    --exclude TVIP/Vehicle_Micro/Templates \
    --exclude TVIP/Vehicle_Micro/Test \
    --exclude TVIP/Vehicle_Micro/VectorCAST \
    --exclude TVIP/Vehicle_Tools/.git \
    --exclude TVIP/Vehicle_Tools/Autogen \
    --exclude TVIP/Vehicle_Tools/BullseyeCoverage \
    --exclude TVIP/Vehicle_Tools/Doxygen \
    --exclude TVIP/Vehicle_Tools/FlexLM \
    --exclude TVIP/Vehicle_Tools/SCRUM \
    --exclude VUC_APP/.git \
    --exclude VUC_APP/application/err \
    --exclude VUC_APP/application/lst \
    --exclude VUC_APP/application/opt \
    --exclude VUC_APP/application/out \
    --exclude VUC_APP/application/tmp \
    --exclude VUC_APP/application/Source/TestCode \
    --exclude VUC_APP/UnitTest_Vcast \
    --exclude VUC_APP/tools \
    --exclude VUC_APP/tmp \
    --exclude VUC_APP/User_Config/App_Example \
    --exclude VUC_APP/User_Config/BSP_I2C_BOLERO \
    --exclude VUC_APP/User_Config/BSP_I2C_RH850F1X \
    --exclude VUC_APP/User_Config/BSP_MCAL_Bolero \
    --exclude VUC_APP/User_Config/BSP_MCAL_RH850F1L \
    --exclude VUC_APP/User_Config/BSP_MCAL_V4_RH850F1L \
    --exclude VUC_APP/User_Config/err \
    --exclude VUC_APP/User_Config/lst \
    --exclude VUC_APP/User_Config/opt \
    --exclude VUC_APP/User_Config/out \
    --exclude VUC_APP/User_Config/Sec \
    --exclude VUC_APP/User_Config/tmp \
    > ${LIST_FILE}
#
echo "generating cscope database: ${DATABASE_FILE} ..."
${CSCOPE} -b -c -i ${LIST_FILE} -f ${DATABASE_FILE}
#
CDBPYSCRIPTLOC="VUC_APP/tools/parsecdb"
CDBNAME="compile_commands.json"
CDBENVVAR="cdbenv.var"
APPROOTDIR="TVIP/Vehicle_Micro"
FBLROOTDIR="VUC_APP/User_Config/Boot_SBU/SBU"
# generating compile_commands.json for APPROOTDIR
pushd "${APPROOTDIR}" > /dev/null
python2 "parsecdb.py" --in "${CDBENVVAR}" --out "${CDBNAME}"
popd > /dev/null
### generating compile_commands.json for FBLROOTDIR
### disable first
# pushd "${FBLROOTDIR}" > /dev/null
# python2 "parsecdb.py" --in "${CDBENVVAR}" --out "${CDBNAME}"
# popd > /dev/null
### combining compile_commands.json
CDBIN1="${APPROOTDIR}/${CDBNAME}"
CDBIN2="${FBLROOTDIR}/${CDBNAME}"
CDBOUT="${CDBNAME}"             # at current directory
python2 VUC_APP/tools/parsecdb/combinecdb.py --in1 "${CDBIN1}" --in2 "${CDBIN2}" --out "${CDBOUT}"
echo "generated ${CDBOUT}"
#
echo "done."
