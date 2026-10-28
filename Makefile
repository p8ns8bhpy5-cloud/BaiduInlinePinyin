export TARGET = iphone:clang:16.5:17.0
export ARCHS = arm64 arm64e
export THEOS_PACKAGE_SCHEME = rootless

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = BaiduInlinePinyin
BaiduInlinePinyin_FILES = Hooks/BaiduInlinePinyin.xm
BaiduInlinePinyin_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk
