.SUFFIXES:

ifeq ($(strip $(DEVKITARM)),)
$(error DEVKITARM n'est pas defini)
endif

TOPDIR ?= $(CURDIR)
PROJECT_ROOT := $(abspath $(TOPDIR))
TARGET := FlashGamesHub
BUILD := build
SOURCES := source
INCLUDES := include
ROMFS := romfs
ARCH := -march=armv6k -mtune=mpcore -mfloat-abi=hard -mtp=soft
LIBDIRS := $(DEVKITPRO)/libctru $(DEVKITPRO)/portlibs/3ds
INCLUDE := $(foreach dir,$(INCLUDES),-I$(PROJECT_ROOT)/$(dir)) $(foreach dir,$(LIBDIRS),-I$(dir)/include) -I$(PROJECT_ROOT)/$(BUILD)

# Use the shell's PATH for the recursive make instead of passing a Windows
# executable path into MSYS/bash or WSL.
MAKE := make

APP_TITLE := Flash Games Hub
APP_DESCRIPTION := Catalogue de jeux homebrew Nintendo 3DS
APP_AUTHOR := Flash Games Hub
APP_ICON := $(PROJECT_ROOT)/assets/hub-icon.png
APP_BANNER := $(PROJECT_ROOT)/assets/hub-banner.png
APP_BANNER_AUDIO := $(PROJECT_ROOT)/assets/silence.wav
RSF := $(PROJECT_ROOT)/cia.rsf
TOOLS := $(DEVKITPRO)/tools/bin

CFLAGS := -g -Wall -Wextra -O2 -mword-relocations -ffunction-sections $(ARCH) -D__3DS__ $(INCLUDE)
CXXFLAGS := $(CFLAGS) -fno-rtti -fno-exceptions -std=gnu++17
ASFLAGS := -g $(ARCH)
LDFLAGS := -specs=3dsx.specs -g $(ARCH) -Wl,--gc-sections
CPPFLAGS := -DCURL_STATICLIB
LIBS := -lcurl -lmbedtls -lmbedx509 -lmbedcrypto -lz -lcitro2d -lcitro3d -lctru -lm
include $(DEVKITARM)/3ds_rules

ifneq ($(BUILD),$(notdir $(CURDIR)))

export DEVKITPRO DEVKITARM
export OUTPUT := $(CURDIR)/$(TARGET)
export TOPDIR := $(CURDIR)
export VPATH := $(foreach dir,$(SOURCES),$(CURDIR)/$(dir))
export DEPSDIR := $(CURDIR)/$(BUILD)

CPPFILES := $(foreach dir,$(SOURCES),$(notdir $(wildcard $(dir)/*.cpp)))
export OFILES_SOURCES := $(CPPFILES:.cpp=.o)
export OFILES := $(OFILES_SOURCES)
export LD := $(CXX)
export LIBPATHS := $(foreach dir,$(LIBDIRS),-L$(dir)/lib)
export INCLUDE
export _3DSXDEPS := $(OUTPUT).smdh
export _3DSXFLAGS += --smdh=$(OUTPUT).smdh --romfs=$(CURDIR)/$(ROMFS)

.PHONY: all clean
all: $(BUILD)
	@$(MAKE) --no-print-directory DEVKITPRO="$(DEVKITPRO)" DEVKITARM="$(DEVKITARM)" -C $(BUILD) -f ../Makefile
	@$(TOOLS)/bannertool.exe makesmdh -s "$(APP_TITLE)" -l "$(APP_DESCRIPTION)" -p "$(APP_AUTHOR)" -i "$(APP_ICON)" -f visible,nosavebackups -o "$(BUILD)/hub.icn"
	@$(TOOLS)/bannertool.exe makebanner -i "$(APP_BANNER)" -a "$(APP_BANNER_AUDIO)" -o "$(BUILD)/hub.bnr"
	@$(TOOLS)/makerom.exe -f cia -o "$(OUTPUT).cia" -target t -elf "$(OUTPUT).elf" -icon "$(BUILD)/hub.icn" -banner "$(BUILD)/hub.bnr" -rsf "$(RSF)"
	@echo built ... $(TARGET).cia

$(BUILD):
	@mkdir -p $@

clean:
	@echo clean ...
	@rm -fr $(BUILD) $(OUTPUT).3dsx $(OUTPUT).cia $(OUTPUT).smdh $(OUTPUT).elf

else

.PHONY: all
all: $(OUTPUT).3dsx

$(OUTPUT).3dsx: $(OUTPUT).elf $(OUTPUT).smdh
$(OUTPUT).elf: $(OFILES)
$(OFILES_SOURCES):

-include $(DEPSDIR)/*.d

endif
