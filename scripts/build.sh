#!/bin/bash
build() {
source build/envsetup.sh || . build/envsetup.sh
bash device/xiaomi/fleur/prebuilts/vendor.sh
lunch $MAKEFILENAME-$VARIENT
export SKIP_ABI_CHECKS=true
export SKIP_API_CHECKS=true
export ALLOW_MISSING_DEPENDENCIES=true
export CCACHE_DIR=/tmp/ccache
export CCACHE_EXEC=$(which ccache)
export USE_CCACHE=1
ccache -M 50G
ccache -o compression=true
ccache -z
$EXTRACMD
$TARGET || curl --upload-file ./out/error.log https://free.keep.sh > link.txt && cat link.txt
}
echo "Initializing Build System"
build
