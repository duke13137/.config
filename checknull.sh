#!/usr/bin/sh

BASE_DIR=~/github/javac-diagnostics-wrapper

export CLASSPATH=$BASE_DIR/build/libs/javac-diagnostics-wrapper-all.jar:$BASE_DIR/checker/dist/checker.jar:$(clj -Spath)

export JAVA_TOOL_OPTIONS="--add-exports=jdk.compiler/com.sun.tools.javac.api=ALL-UNNAMED --add-exports=jdk.compiler/com.sun.tools.javac.code=ALL-UNNAMED --add-exports=jdk.compiler/com.sun.tools.javac.file=ALL-UNNAMED --add-exports=jdk.compiler/com.sun.tools.javac.main=ALL-UNNAMED --add-exports=jdk.compiler/com.sun.tools.javac.model=ALL-UNNAMED --add-exports=jdk.compiler/com.sun.tools.javac.processing=ALL-UNNAMED --add-exports=jdk.compiler/com.sun.tools.javac.tree=ALL-UNNAMED --add-exports=jdk.compiler/com.sun.tools.javac.util=ALL-UNNAMED --add-opens=jdk.compiler/com.sun.tools.javac.comp=ALL-UNNAMED"

java io.github.wmdietl.diagnostics.json.javac.Main -processor org.checkerframework.checker.nullness.NullnessChecker "$@" 2>/dev/null | tee nullness.log
