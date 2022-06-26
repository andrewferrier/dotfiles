#!/usr/bin/env bash

if [[ ${OSTYPE} == darwin* && -x /usr/libexec/java_home ]]; then
    JAVA_VERSION="1.8"

    JAVA_HOME_INTERMEDIARY=$(/usr/libexec/java_home -v ${JAVA_VERSION} 2>/dev/null)
    RC=$?
    if [ ${RC} -eq 0 ]; then
        export JAVA_HOME=${JAVA_HOME_INTERMEDIARY}
    fi
fi
