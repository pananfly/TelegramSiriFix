ARCHS = arm64 arm64e
TARGET = iphone:clang:latest:15.0

INSTALL_TARGET_PROCESSES = Telegram Swiftgram

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = TelegramSideloadFix

TelegramSideloadFix_FILES = Tweak.xm
TelegramSideloadFix_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
