#!/bin/bash
export PATH=$HOME/bin:/usr/local/bin:$PATH:/opt/homebrew/bin

SWIFTGEN=./Configuration/Swiftgen
BUILDED=$SWIFTGEN/Generated

GENERATED_PROJ=./Weather/Resources
LOGS_FOLDER=./Logs


if which swiftgen >/dev/null; then
    if [ ! -d "$LOGS_FOLDER" ]; then
        mkdir "$LOGS_FOLDER" 2>/dev/null
    fi

    rm -rf "$SWIFTGEN/Generated" > /dev/null
    rm -rf "$GENERATED_PROJ/Generated" > /dev/null

    mkdir "$SWIFTGEN/Generated" 2>/dev/null
    mkdir "$GENERATED_PROJ/Generated" 2>/dev/null

    swiftgen config run --config "$SWIFTGEN/SwiftgenMainTarget.yml" > "./Logs/SwiftgenMain.log" 2>&1

    TXT=$(cat "./Logs/SwiftgenMain.log")

    echo "warning: Swiftgen ./Logs/SwiftgenMain.log result text:\n$TXT"

    if [ -f "$BUILDED/Assets.swift" ]; then
        mv "$BUILDED/Assets.swift" "$GENERATED_PROJ/Generated/Assets.swift"
    else
        echo "error: missing file, cant move file at: $BUILDED/Assets.swift"
    fi

    rm -rf "$SWIFTGEN/Generated" > /dev/null
else
    echo "warning: Swiftgen not installed"
fi
