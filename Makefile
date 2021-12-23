TARGET = iphone:clang:latest:13.0
ARCHS = arm64 arm64e

DEBUG=0
FINALPACKAGE=1
CODESIGN_IPA=0

PACKAGE_VERSION=1.0

MODULES = jailed
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = YoutubeReborn
DISPLAY_NAME = YouTube

$(TWEAK_NAME)_FILES = Tweak.xm
$(TWEAK_NAME)_CFLAGS = -fobjc-arc
$(TWEAK_NAME)_IPA = ipa/YouTube_16.46.5.ipa
$(TWEAK_NAME)_INJECT_DYLIBS = Dylibs/*.dylib

include $(THEOS_MAKE_PATH)/tweak.mk
