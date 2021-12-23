#!/bin/bash
__compile_tweaks() {
  echo "Compiling tweaks..."
  
  [ -d "$PARENT_PATH"/Dylibs ] || mkdir "$PARENT_PATH"/Dylibs >/dev/null 2>&1
  TARGET="iphone:clang:latest:13.0"
  
  for d in "$PARENT_PATH"/Tweaks/*/ ; do
    if [ -f "$d"/Makefile ]; then
      (cd "$d" \
       && make ARCHS="$ARCH" TARGET=$TARGET DEBUG=0 -j8 -s \
       && rsync -acz -q .theos/obj/"$ARCH"/*.dylib "$PARENT_PATH"/Dylibs);
    fi
  done
}

__package_ipa() {
  echo "Packaging ipa"
  make package -j8 -s ARCHS="$ARCH"
}

__change_alderis_rpath() {
  if [ -f "$PARENT_PATH/Dylibs/iSponsorBlock.dylib" ]; then
    echo "Modifying Alderis rpath"
    install_name_tool -change "/Library/Frameworks/Alderis.framework/Alderis" "@rpath/Alderis.framework/Alderis" "$PARENT_PATH"/Dylibs/iSponsorBlock.dylib
  fi
}

__export_ipa() {
  echo "Copying ipa to iCloud Drive"
  if [[ ! -L "$HOME/iDrive" ]]; then
    ln -s "$HOME/Library/Mobile\ Documents/com~apple~CloudDocs" "$HOME"/iDrive
  fi

  rsync -acz "$PARENT_PATH"/packages/*.ipa "$HOME"/iDrive
}

__copy_bundles() {
  echo "Copying bundles..."
  
  [ -d "$PARENT_PATH"/Resources ] || mkdir "$PARENT_PATH"/Resources >/dev/null 2>&1
    
  if [ -f "$PARENT_PATH/Dylibs/YouPiP.dylib" ]; then
    echo "Copying YouPiP resources bundle"
    rsync -acz "$PARENT_PATH/Tweaks/YouPiP/layout/Library/'Application Support'/YouPiP.bundle" "$PARENT_PATH"/Resources/YouPiP.bundle
  fi

  if [ -f "$PARENT_PATH/Dylibs/iSponsorBlock.dylib" ]; then
    echo "Copying iSponsorBlock resources bundle"
    rsync -acz "$PARENT_PATH"/Tweaks/iSponsorBlock/.theos/obj/com.galacticdev.isponsorblock.bundle "$PARENT_PATH"/Resources/
  fi
}

echo 'Please choose an arch:'
select input in arm64 arm64e
do
    case $input in
      arm64|arm64e)
        ARCH=$input
        break
        ;;
      *)
        echo "Invalid arch"
        ;;
    esac
done

PARENT_PATH=$(cd "$(dirname "${BASH_SOURCE[0]}")" || exit; pwd -P )
  __compile_tweaks
  __copy_bundles
  __change_alderis_rpath
  __package_ipa
  __export_ipa
