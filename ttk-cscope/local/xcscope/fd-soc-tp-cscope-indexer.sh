#!/bin/sh
#
#
LIST_FILE="fd-cscope.files"
DATABASE_FILE="cscope.out"
FIND="fd --ignore-case --type f"
CSCOPE="cscope"

${FIND} '\.([chly](xx|pp)*|cc|hh)$' \
    --exclude .git \
    --exclude .repo \
    --exclude package/arm \
    --exclude -e '/\/package\/codeaurora\//d' -e '/\/package\/opensource\//d' -e '/\/package\/valens\//d' -e '/\/package\/specs\//d' -e '/\/package\/qualcomm\//d' -e '/\/tools\//d' -e '/\/release-toolchain\//d' -e '/\/release-host\//d' -e '/\/release\//d' -e '/\/project\//d' -e '/\/platform-hal\//d' -e '/\/platform-framework\//d' -e '/\/platform\//d' -e '/\/logs\//d' -e '/\/.build\//d' -e '/\/.repo\//d' -e '/\/CVS\//d' -e '/\/RCS\//d' -e '/^\.svn\//d' -e '/\/.git\//d' -e '/\/.hg\//d' -e 's/^\.\///' | \


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

${CSCOPE} -b -c -i ${LIST_FILE} -f ${DATABASE_FILE}
