#!/bin/sh
 
# openbsd 4.9
# gcc 4.2.1
# openjdk 1.7.0

OPENALPR_INCLUDE_DIR=/storage/projects/alpr/src/openalpr/
OPENALPR_LIB_DIR=/storage/projects/alpr/src/build/openalpr/
JAVA_PATH=/usr/lib/jvm/java-1.7.0-openjdk-amd64

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:.:${OPENALPR_LIB_DIR}
# Compile java
javac -Xlint:unchecked src/org/openalpr/json/*.java src/org/openalpr/*.java  src/Main.java

# Create native header from Alpr java file
javah -classpath src org.openalpr.AlprJNIWrapper

# Compile/link native interface
g++ -Wall -L${OPENALPR_LIB_DIR} -I${JAVA_PATH}/include/ -I${OPENALPR_INCLUDE_DIR} -shared -fPIC -o libopenalpr-native.so openalpr-native.cpp -lopenalpr

# Test
java -classpath src Main