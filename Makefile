include theos/makefiles/common.mk
export GO_EASY_ON_ME=1
TWEAK_NAME = PlayingLyrics
PlayingLyrics_FILES = Tweak.xm
PlayingLyrics_PRIVATE_FRAMEWORKS = MediaPlayer 
PlayingLyrics_FRAMEWORKS = UIKit MediaPlayer
PlayingLyrics_LDFLAGS = -lactivator
include $(THEOS_MAKE_PATH)/tweak.mk
