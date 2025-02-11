.SUFFIXES:
#---------------------------------------------------------------------------------
ifeq ($(strip $(DEVKITPPC)),)
$(error "Please set DEVKITPPC in your environment. export DEVKITPPC=<path to>devkitPPC")
endif

SUBPROJECTS := dolbooter bootloader installer discloader libGUI main copy
.PHONY: all forced clean $(SUBPROJECTS)

all: main
forced: clean all

dolbooter:
	@echo " "
	@echo "Building RVLoader dolbooter"
	@echo " "
	$(MAKE) -C dolbooter

bootloader: dolbooter
	@echo " "
	@echo "Building RVLoader bootloader"
	@echo " "
	$(MAKE) -C bootloader

installer: bootloader
	@echo " "
	@echo "Building RVLoader installer"
	@echo " "
	$(MAKE) -C installer

discloader:
	@echo " "
	@echo "Building RVLoader discloader"
	@echo " "
	$(MAKE) -C discloader

libGUI:
	@echo " "
	@echo "Building RVLoader libGUI"
	@echo " "
	$(MAKE) -C libGUI install

main: dolbooter bootloader installer discloader
	@echo " "
	@echo "Building RVLoader main"
	@echo " "
	$(MAKE) -C main

copy: main
	@echo " "
	@echo "Copying build to external drive"
	@echo " "
	@cp main/boot.dol /Volumes/SANDISK/apps/rvloader

clean:
	@echo " "
	@echo "Cleaning all subprojects..."
	@echo " "
	$(MAKE) -C dolbooter clean
	$(MAKE) -C bootloader clean
	$(MAKE) -C installer clean
	$(MAKE) -C discloader clean
	$(MAKE) -C libGUI clean
	$(MAKE) -C main clean