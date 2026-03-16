ARCHS = arm64 arm64e
TARGET = iphone:clang:latest:15.0

INSTALL_TARGET_PROCESSES = Telegram Swiftgram

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = TelegramSiriFix

TelegramSideloadFix_FILES = Tweak.x
TelegramSideloadFix_FRAMEWORKS = Foundation Intents CallKit

include $(THEOS_MAKE_PATH)/tweak.mk
