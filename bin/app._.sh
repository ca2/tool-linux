#!/bin/bash

#   $(#archive)/tool-linux/bin/app._.sh $(WORKSPACE_DIR) $(PROJECT_DIR) $(TARGET_NAME) $(PROJECT_NAME) $(#platform_modifier) $(#archive) $(#config) app-core/weather


buildapp() {

   export WORKSPACEDIR="$1"
   export PROJECTDIR="$2"
   export TARGETNAME="$3"
   export PROJECTNAME="$4"
   export PLATFORM_MODIFIER="$5"
   export ARCHIVE="$6"
   export CONFIG="$7"
   export _APP_ID="$8"

   cd "$PROJECTDIR"

   g++ -D_APP_ID=\"$_APP_ID\" -std=c++17 -fpermissive -fexceptions -fnon-call-exceptions -fno-pie -fno-stack-protector -Wno-pointer-arith -Wno-attributes -Winvalid-pch -Wno-conversion-null -fPIC -g -D_DEBUG -I. -I$PROJECTDIR -I$ARCHIVE -I$CONFIG -I$WORKSPACEDIR/../.. -I$WORKSPACEDIR/../../inc -I$WORKSPACEDIR/../../../source -I$WORKSPACEDIR/../../../source/include -I$WORKSPACEDIR/../../platform-linux -I$WORKSPACEDIR/../../platform-linux/_include -I$WORKSPACEDIR/../../../source/app/_include -I$WORKSPACEDIR/../../../source/app -I$WORKSPACEDIR/../../../source/app/aura -I/sensitive/sensitive/include -c $WORKSPACEDIR/../../platform-linux/app/main.cpp -o $WORKSPACEDIR/../../../time-$PLATFORM_MODIFIER/intermediate/$TARGETNAME/$PROJECTNAME/main.cpp.o
   
   g++ -L$WORKSPACEDIR/../../../time-$PLATFORM_MODIFIER/x64/$TARGETNAME -L/usr/lib64/mysql/ -o $WORKSPACEDIR/../../../time-$PLATFORM_MODIFIER/x64/$TARGETNAME/$PROJECTNAME $WORKSPACEDIR/../../../time-$PLATFORM_MODIFIER/intermediate/$TARGETNAME/$PROJECTNAME/main.cpp.o  -Wl,-rpath=$ORIGIN -lacme -lapex -Wl,-z,defs -g

}


buildapp "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8"



