#!/bin/bash

TAR_CMD=tar
VERSION=0.3.0

git archive --prefix=RAJAPerf-${VERSION}/ -o RAJAPerf-${VERSION}.tar HEAD 2> /dev/null

echo "Running git archive submodules..."

p=`pwd` && (echo .; git submodule foreach) | while read entering path; do
    temp="${path%\'}";
    temp="${temp#\'}";
    path=$temp;
    [ "$path" = "" ] && continue;
    (cd $path && git archive --prefix=RAJAPerf-${VERSION}/$path/ HEAD > $p/tmp.tar && ${TAR_CMD} --concatenate --file=$p/RAJAPerf-${VERSION}.tar $p/tmp.tar && rm $p/tmp.tar);
done

gzip RAJAPerf-${VERSION}.tar
