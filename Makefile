include theos/makefiles/common.mk

TWEAK_NAME = PlayingLyrics
PlayingLyrics_FILES = Tweak.mm
PlayingLyrics_FRAMEWORKS = UIKit MediaPlayer
PlayingLyrics_LDFLAGS = -lactivator

include $(THEOS_MAKE_PATH)/tweak.mk
