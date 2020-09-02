!#/bin/bash

#   $(#archive)/tool-linux/bin/app._.sh $(WORKSPACE_DIR) $(PROJECT_DIR) $(TARGET_NAME) $(PROJECT_NAME) $(#time_name) $(#archive) $(#config) app-core/weather


buildapp() {

   export WORKSPACEDIR="$1"
   export PROJECTDIR="$2"
   export TARGETNAME="$3"
   export PROJECTNAME="$4"
   export TIME_NAME="$5"
   export ARCHIVE="$6"
   export CONFIG="$7"
   export MAINAPPID="$8"

   cd "$PROJECTDIR"

   g++ -DMAINAPPID=\"$MAINAPPID\" -std=c++17 -fpermissive -fexceptions -fnon-call-exceptions -fno-pie -fno-stack-protector -Wno-pointer-arith -Wno-attributes -Winvalid-pch -Wno-conversion-null -fPIC -g -D_DEBUG -I. -I$PROJECTDIR -I$ARCHIVE -I$CONFIG -I$WORKSPACEDIR/../.. -I$WORKSPACEDIR/../../inc -I$WORKSPACEDIR/../../include -I$WORKSPACEDIR/../../platform-linux -I$WORKSPACEDIR/../../app/_include -I$WORKSPACEDIR/../../app -I$WORKSPACEDIR/../../app/aura -I/sensitive/sensitive/include -c ../../platform-linux/app/main.cpp -o ../../$TIME_NAME/intermediate/$TARGETNAME/$PROJECTNAME/main.cpp.o
   
   g++ -L../../$TIME_NAME/x64/$TARGETNAME -L/usr/lib64/mysql/ -o ../../$TIME_NAME/x64/$TARGETNAME/$PROJECTNAME ../../$TIME_NAME/intermediate/$TARGETNAME/$PROJECTNAME/main.cpp.o  -Wl,-rpath=\$ORIGIN -laura -Wl,-z,defs -g

}


buildapp "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8"



