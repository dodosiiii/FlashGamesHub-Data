DEVKITPRO ?= /c/devkitPro
DEVKITARM ?= $(DEVKITPRO)/devkitARM
TARGET := cheeseria
BUILD := build
SOURCES := source
INCLUDES := include
ARCH := -march=armv6k -mtune=mpcore -mfloat-abi=hard -mtp=soft
CXX := $(DEVKITARM)/bin/arm-none-eabi-g++
3DSXTOOL := $(DEVKITPRO)/tools/bin/3dsxtool
TEX3DS := $(DEVKITPRO)/tools/bin/tex3ds
BANNERTOOL := $(DEVKITPRO)/tools/bin/bannertool
LIBDIRS := $(DEVKITPRO)/libctru $(DEVKITPRO)/portlibs/3ds
INCLUDE := $(foreach dir,$(INCLUDES),-I$(dir)) -I$(BUILD) $(foreach dir,$(LIBDIRS),-I$(dir)/include)
CXXFLAGS := -g -Wall -Wextra -Werror -O2 -mword-relocations -ffunction-sections \
	$(ARCH) -D__3DS__ $(INCLUDE) -MMD -MP -fno-rtti -fno-exceptions -std=gnu++17
LDFLAGS := -specs=3dsx.specs -g $(ARCH) -Wl,--gc-sections \
	$(foreach dir,$(LIBDIRS),-L$(dir)/lib)
LIBS := -lcitro2d -lcitro3d -lctru -lm
OBJECTS := $(BUILD)/game.o $(BUILD)/main_3ds.o
ROMFS_ASSETS := romfs/gfx/ingredients.t3x romfs/audio/orderscreen_music.wav \
	romfs/audio/buttonclick.wav

.PHONY: all clean
all: $(BUILD)/$(TARGET).3dsx

$(BUILD):
	mkdir -p $@

romfs/gfx/ingredients.t3x: assets/ingredients/ingredients.t3s \
	assets/ingredients/bread_white.png assets/ingredients/bread_wheat.png \
	assets/ingredients/cheddar.png assets/ingredients/mozzarella.png | $(BUILD)
	mkdir -p romfs/gfx
	$(TEX3DS) -i $< -o $@

romfs/audio/orderscreen_music.wav: assets/audio/orderscreen_music.wav
	mkdir -p romfs/audio
	cp $< $@

romfs/audio/buttonclick.wav: assets/audio/buttonclick.wav
	mkdir -p romfs/audio
	cp $< $@

$(BUILD)/game.o: $(SOURCES)/game.cpp include/game.hpp | $(BUILD)
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(BUILD)/main_3ds.o: $(SOURCES)/main_3ds.cpp include/game.hpp | $(BUILD)
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(BUILD)/$(TARGET).elf: $(OBJECTS)
	$(CXX) $(LDFLAGS) -o $@ $^ $(LIBS)

$(BUILD)/$(TARGET).smdh: assets/icon.png | $(BUILD)
	$(BANNERTOOL) makesmdh -s "Cheese Shop 3DS" \
		-l "Independent cheese shop remake prototype" \
		-p "Community" -i $< -f visible,nosavebackups -o $@

$(BUILD)/$(TARGET).3dsx: $(BUILD)/$(TARGET).elf $(BUILD)/$(TARGET).smdh $(ROMFS_ASSETS)
	$(3DSXTOOL) $(BUILD)/$(TARGET).elf $@ \
		--smdh=$(BUILD)/$(TARGET).smdh --romfs=romfs

clean:
	rm -f $(OBJECTS) $(BUILD)/$(TARGET).elf $(BUILD)/$(TARGET).3dsx \
		$(BUILD)/$(TARGET).smdh \
		$(BUILD)/game.d $(BUILD)/main_3ds.d \
		romfs/gfx/ingredients.t3x romfs/audio/orderscreen_music.wav \
		romfs/audio/buttonclick.wav

-include $(BUILD)/game.d $(BUILD)/main_3ds.d
