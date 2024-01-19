#!/bin/bash

#!/bin/bash

set -e

if [[ "${SKIPUPDATE,,}" != "true" ]]; then
    if [[ "${STEAMBETA,,}" == "true" ]]; then
        printf "Experimental flag is set. Experimental will be downloaded instead of Early Access.\\n"
        STEAMBETAFLAG="experimental"
    else
        STEAMBETAFLAG="public"
    fi

    STORAGEAVAILABLE=$(stat -f -c "%a*%S" .)
    STORAGEAVAILABLE=$((STORAGEAVAILABLE/1024/1024/1024))
    printf "Checking available storage...%sGB detected\\n" "$STORAGEAVAILABLE"

    if [[ "$STORAGEAVAILABLE" -lt 8 ]]; then
        printf "You have less than 8GB (%sGB detected) of available storage to download the game.\\nIf this is a fresh install, it will probably fail.\\n" "$STORAGEAVAILABLE"
    fi

    printf "Downloading the latest version of the game...\\n"
    steamcmd +force_install_dir /config/gamefiles +login anonymous +app_update "$STEAMAPPID" -beta "$STEAMBETAFLAG" validate +quit
else
    printf "Skipping update as flag is set\\n"
fi


if [ ! -f "/opt/palworld/PalServer.sh" ]; then
    printf "Palworld launch script is missing.\\n"
    exit 1
fi
MULTITHREAD=""
if [[ -n $ENABLE_MULTITHREAD ]] && [[ $ENABLE_MULTITHREAD == "true" ]];then
    MULTITHREAD="-useperfthreads -NoAsyncLoadingThread -UseMultithreadForDS"
fi

community_opts=""
if [[ -n $IS_PUBLIC ]] && [[ $IS_PUBLIC == "true" ]];then
    community_opts="EpicApp=PalServer"
fi
if [[ -n $PUBLIC_IP ]];then
    community_opts="$community_opts -publicip=$PUBLIC_IP"
fi
if [[ -n $PUBLIC_PORT ]];then
    community_opts="$community_opts -publicport=$PUBLIC_PORT"
fi


exec ./PalServer.sh port="$PORT" players=$PLAYERS "$MULTITHREAD" "$community_opts" "$@"

