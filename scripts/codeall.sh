


mkdir -p $HOME/__archive/sensitive


mkdir -p $HOME/__archive/archive


mkdir -p $HOME/__archive/basis

svn checkout https://ca2.io/internal/sensitive $HOME/__archive/sensitive/sensitive

svn checkout https://ca2.io/app/basis $HOME/__archive/basis/app
svn checkout https://ca2.io/app-cidadedecuritiba/basis $HOME/__archive/basis/app-cidadedecuritiba
svn checkout https://ca2.io/app-core/basis $HOME/__archive/basis/app-core
svn checkout https://ca2.io/shared/app-simple/basis $HOME/__archive/basis/app-simple
svn checkout https://ca2.io/app-veriwell/basis $HOME/__archive/basis/app-veriwell
svn checkout https://ca2.io/ca2/basis $HOME/__archive/basis/ca2
svn checkout https://ca2.io/design/basis $HOME/__archive/basis/design
svn checkout https://ca2.io/game/basis $HOME/__archive/basis/game
svn checkout https://ca2.io/include/basis $HOME/__archive/basis/include
svn checkout https://ca2.io/platform-linux/basis $HOME/__archive/basis/platform-linux
svn checkout https://ca2.io/third/basis $HOME/__archive/basis/third


svn checkout https://ca2.io/shared/platform-linux/basis $HOME/__archive/operating-system/operating-system-linux
svn checkout https://ca2.io/shared/storage-linux/basis $HOME/__archive/archive/storage-linux
svn checkout https://ca2.io/shared/tool-linux $HOME/__archive/archive/tool-linux


