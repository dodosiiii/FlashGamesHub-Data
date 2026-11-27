.SUFFIXES:

ifeq ($(strip $(DEVKITARM)),)
$(error DEVKITARM is not set)
endif

TOPDIR ?= $(CURDIR)
PROJECT_ROOT := $(abspath $(TOPDIR))
PARENT_ROOT := $(abspath $(TOPDIR)/..)
TARGET := $(PARENT_ROOT)/FlashGamesHubDiag
BUILD := build
ARCH := -march=armv6k -mtune=mpcore -mfloat-abi=hard -mtp=soft
LIBDIRS := $(DEVKITPRO)/libctru $(DEVKITPRO)/portlibs/3ds
INCLUDE := -I$(PARENT_ROOT)/include $(foreach dir,$(LIBDIRS),-I$(dir)/include)

CFLAGS := -g -Wall -O2 -mword-relocations -ffunction-sections $(ARCH) -D__3DS__ $(INCLUDE)
CXXFLAGS := $(CFLAGS) -fno-rtti -fno-exceptions -std=gnu++17
ASFLAGS := -g $(ARCH)
LDFLAGS := -specs=3dsx.specs -g $(ARCH) -Wl,--gc-sections
CPPFLAGS := -DCURL_STATICLIB
LIBS := -lcurl -lmbedtls -lmbedx509 -lmbedcrypto -lz -lctru -lm

include $(DEVKITARM)/3ds_rules

OBJS := $(BUILD)/diag_main.o $(BUILD)/catalog.o $(BUILD)/embedded_romfs.o

.PHONY: all clean
all: $(TARGET).3dsx $(TARGET).cia

$(BUILD):
	@mkdir -p $(BUILD)

$(BUILD)/diag_main.o: source/main.cpp | $(BUILD)
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) -c $< -o $@

$(BUILD)/catalog.o: $(PARENT_ROOT)/source/catalog.cpp | $(BUILD)
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) -c $< -o $@

$(BUILD)/embedded_romfs.o: $(PARENT_ROOT)/source/embedded_romfs.cpp | $(BUILD)
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) -c $< -o $@

$(TARGET).elf: $(OBJS)
	$(CXX) $(LDFLAGS) $(OBJS) $(foreach dir,$(LIBDIRS),-L$(dir)/lib) $(LIBS) -o $@

$(TARGET).3dsx: $(TARGET).elf
	$(DEVKITPRO)/tools/bin/3dsxtool.exe $< $@ --smdh=$(PARENT_ROOT)/FlashGamesHub.smdh --romfs=$(PARENT_ROOT)/romfs

$(TARGET).cia: $(TARGET).elf
	cd $(PARENT_ROOT) && $(DEVKITPRO)/tools/bin/makerom.exe -f cia -o $@ -target t -elf $< -icon $(PARENT_ROOT)/build/hub.icn -banner $(PARENT_ROOT)/build/hub.bnr -rsf $(PARENT_ROOT)/cia.rsf

clean:
	@rm -rf $(BUILD) $(TARGET).elf $(TARGET).3dsx $(TARGET).cia
