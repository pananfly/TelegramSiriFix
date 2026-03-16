TARGET := iphone:clang:latest:14.0
ARCHS := arm64 arm64e
DEBUG := 0
FINALPACKAGE := 1

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = TelegramSiriFix
TelegramSiriFix_FILES = Tweak.x
TelegramSiriFix_CFLAGS = -fobjc-arc
TelegramSiriFix_FRAMEWORKS = Intents

include $(THEOS_MAKE_PATH)/tweak.mk
