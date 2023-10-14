#!/bin/bash
build() {
source build/envsetup.sh || . build/envsetup.sh
bash device/xiaomi/viva/prebuilts/vendor.sh
lunch $MAKEFILENAME-$VARIENT
export CCACHE_DIR=/tmp/ccache
export CCACHE_EXEC=$(which ccache)
export USE_CCACHE=1
ccache -M 100G
ccache -o compression=true
ccache -z
$EXTRACMD
$TARGET & sleep 95m #|| curl --upload-file ./out/error.log https://free.keep.sh > link.txt && cat link.txt
}
echo "Initializing Build System"
build
