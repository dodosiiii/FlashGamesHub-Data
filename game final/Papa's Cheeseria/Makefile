#---------------------------------------------------------------------------------
# Makefile — Papa's Cheeseria 3DS
# Structure standard devkitPro (un seul Makefile, pas de sous-make)
#---------------------------------------------------------------------------------
.SUFFIXES:

ifeq ($(strip $(DEVKITPRO)),)
  $(error "DEVKITPRO n'est pas défini. Lancez via build.ps1 ou source /etc/profile")
endif

include $(DEVKITPRO)/devkitARM/base_rules

#---------------------------------------------------------------------------------
# Répertoires
#---------------------------------------------------------------------------------
BUILD       := build
SOURCES     := source
INCLUDES    := include
ROMFS       := romfs
META        := meta

#---------------------------------------------------------------------------------
# Infos du projet
#---------------------------------------------------------------------------------
TARGET      := cheeseria
TITLE       := Papa's Cheeseria
DESCRIPTION := Port 3DS homebrew
AUTHOR      := FlashGamesHub

ICON        := $(META)/icon.png
BANNER_IMG  := $(META)/banner.png
BANNER_WAV  := $(META)/banner.wav
RSF         := cheeseria.rsf

#---------------------------------------------------------------------------------
# Options du compilateur
#---------------------------------------------------------------------------------
ARCH     := -march=armv6k -mtune=mpcore -mfloat-abi=hard -mtp=soft
CFLAGS   := -g -Wall -Wextra -O2 -mword-relocations -fomit-frame-pointer \
             -ffunction-sections $(ARCH) -D__3DS__
CXXFLAGS := $(CFLAGS) -std=c++17 -fno-rtti -fno-exceptions
ASFLAGS  := -g $(ARCH)
LDFLAGS  := -specs=3dsx.specs -g $(ARCH) -Wl,-Map,$(BUILD)/$(TARGET).map

LIBS     := -lcitro2d -lcitro3d -lctru -lm

#---------------------------------------------------------------------------------
# Résolution des chemins (sans export — VPATH doit être une variable make simple)
#---------------------------------------------------------------------------------
LIBDIRS  := $(DEVKITPRO)/libctru \
            $(DEVKITPRO)/portlibs/3ds

# VPATH : make cherche les sources dans ces dossiers pour les règles %.o: %.cpp etc.
# Utiliser des chemins relatifs pour éviter les problèmes d'espaces dans le chemin absolu
VPATH    := $(SOURCES)

INCLUDE  := $(foreach dir,$(INCLUDES),-I$(dir)) \
            $(foreach dir,$(LIBDIRS),-I$(dir)/include) \
            -I$(BUILD)
LIBPATHS := $(foreach dir,$(LIBDIRS),-L$(dir)/lib)

# Mise à jour des flags avec les includes maintenant définis
CFLAGS   += $(INCLUDE)
CXXFLAGS += $(INCLUDE)

# Liste des fichiers sources (chemins relatifs — pas de problème d'espaces)
CFILES   := $(foreach dir,$(SOURCES),$(notdir $(wildcard $(dir)/*.c)))
CPPFILES := $(filter-out main_host.cpp,$(foreach dir,$(SOURCES),$(notdir $(wildcard $(dir)/*.cpp))))
SFILES   := $(foreach dir,$(SOURCES),$(notdir $(wildcard $(dir)/*.s)))

OFILES   := $(addprefix $(BUILD)/,$(CPPFILES:.cpp=.o) $(CFILES:.c=.o) $(SFILES:.s=.o))

# Flags 3DSX
_3DSXFLAGS :=
ifeq ($(strip $(NO_SMDH)),)
  _3DSXFLAGS += --smdh=$(BUILD)/$(TARGET).smdh
endif
ifneq ($(ROMFS),)
  _3DSXFLAGS += --romfs="$(CURDIR)/$(ROMFS)"
endif

#---------------------------------------------------------------------------------
# Cibles principales
#---------------------------------------------------------------------------------
.PHONY: all clean cia assets

all: assets $(BUILD)/$(TARGET).3dsx

#── 3DSX ────────────────────────────────────────────────────────────────────────
$(BUILD)/$(TARGET).3dsx: $(BUILD)/$(TARGET).elf $(BUILD)/$(TARGET).smdh
	@3dsxtool $< $@ $(_3DSXFLAGS)
	@echo "3DSX : $@"

$(BUILD)/$(TARGET).elf: $(OFILES) | $(BUILD)
	@echo "Linkage → $@"
	@$(CXX) $(LDFLAGS) $(LIBPATHS) -o $@ $^ $(LIBS)

$(BUILD)/$(TARGET).smdh: $(ICON) | $(BUILD)
	@bannertool makesmdh \
	    -s "$(TITLE)" \
	    -l "$(DESCRIPTION)" \
	    -p "$(AUTHOR)" \
	    -i $< \
	    -o $@

#── Règles de compilation ────────────────────────────────────────────────────────
# VPATH permet à make de trouver source/audio_3ds.cpp quand il cherche audio_3ds.cpp
$(BUILD)/%.o: %.cpp | $(BUILD)
	@echo "  CXX $<"
	@$(CXX) -MMD -MP -MF $(BUILD)/$*.d $(CXXFLAGS) -c -o $@ $<

$(BUILD)/%.o: %.c | $(BUILD)
	@echo "  CC  $<"
	@$(CC) -MMD -MP -MF $(BUILD)/$*.d $(CFLAGS) -c -o $@ $<

$(BUILD)/%.o: %.s | $(BUILD)
	@echo "  AS  $<"
	@$(AS) $(ASFLAGS) -o $@ $<

$(BUILD):
	@mkdir -p $@

#── CIA ──────────────────────────────────────────────────────────────────────────
cia: assets $(BUILD)/$(TARGET).cia

$(BUILD)/$(TARGET).cia: $(BUILD)/$(TARGET).elf $(BUILD)/$(TARGET).smdh \
                         $(BUILD)/$(TARGET).bnr $(RSF)
	@makerom -f cia \
	    -o $@ \
	    -elf $(BUILD)/$(TARGET).elf \
	    -rsf $(RSF) \
	    -icon $(BUILD)/$(TARGET).smdh \
	    -banner $(BUILD)/$(TARGET).bnr \
	    -exefslogo \
	    -target t \
	    -DAPP_ROMFS=$(ROMFS)
	@echo "CIA généré : $@"

$(BUILD)/$(TARGET).bnr: $(BANNER_IMG) $(BANNER_WAV) | $(BUILD)
	@bannertool makebanner \
	    -i $(BANNER_IMG) \
	    -a $(BANNER_WAV) \
	    -o $@

#── Assets (atlas tex3ds) ────────────────────────────────────────────────────────
# Tous les assets/*/*.t3s sont convertis en romfs/gfx/<nom>.t3x (ingredients, ui, atlas_01...).
# Les atlas générés par tools/prepare_assets.py sont dans assets/atlases/.
define T3S_RULE
$(ROMFS)/gfx/$(basename $(notdir $(1))).t3x: $(1) $(wildcard $(dir $(1))*.png $(dir $(1))*/*.png)
	@mkdir -p $(ROMFS)/gfx
	@tex3ds -i $(1) -o $$@
	@echo "Atlas $(1) -> $$@"
endef

T3S_FILES := $(wildcard assets/*/*.t3s)
T3X_FILES := $(foreach f,$(T3S_FILES),$(ROMFS)/gfx/$(basename $(notdir $(f))).t3x)
$(foreach f,$(T3S_FILES),$(eval $(call T3S_RULE,$(f))))

assets: $(T3X_FILES)

#── Nettoyage ────────────────────────────────────────────────────────────────────
clean:
	@rm -rf $(BUILD)
	@echo "Nettoyage terminé."

#── Dépendances auto-générées ─────────────────────────────────────────────────────
-include $(wildcard $(BUILD)/*.d)
