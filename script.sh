#!/bin/bash

export JAVA_HOME="/home/alex/.jdks/temurin-17.0.9";
export MAIN_JAR=target/FxDemo-1.0-SNAPSHOT
detected_modules=$JAVA_HOME/bin/jdeps --ignore-missing-deps --multi-release=17 --print-module-deps target/classes/vi/al/ro/Main.class
manual_modules=jdk.localedata;
$JAVA_HOME/bin/jlink \
  --no-header-files \
  --no-man-pages \
  --compress=2 \
  --strip-debug \
  --add-modules "${detected_modules},${manual_modules}" \
  --include-locales=en \
  --output target/java-runtime;
echo $MAIN_JAR
for type in app-image rpm deb
do
  $JAVA_HOME/bin/jpackage \
  --type $type \
  --dest target/installer \
  --input target/installer/input/libs \
  --name JPackageScriptFX \
  --main-class vi.al.ro.Main \
  --main-jar ${MAIN_JAR} \
  --java-options -Xmx2048m \
  --runtime-image target/java-runtime \
  --app-version ${APP_VERSION} \
>    --vendor "ACME Inc." \
  --copyright "Copyright © 2019-21 ACME Inc.";
done
