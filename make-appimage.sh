#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q qtcreator | awk '{print $2; exit}')
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=/usr/share/icons/hicolor/256x256/apps/QtProject-qtcreator.png
export DESKTOP=/usr/share/applications/org.qt-project.qtcreator.desktop
export USE_HOST_DRIVERS_EXPERIMENTAL=1

# Deploy dependencies
quick-sharun /usr/bin/qtcreator /usr/lib/qtcreator /usr/share/qtcreator /usr/lib/libQt6TaskTree.so* /usr/include/qt6/QtTaskTree

# Turn AppDir into AppImage
quick-sharun --make-appimage
