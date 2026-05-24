TARGET = EBOOT
BUILD = build
SOURCES = .
INCLUDES =
LIBDIR =
LIBS = -lm

EXTRA_TARGETS = EBOOT.PBP
PSP_EBOOT_TITLE = Inferno Jump

PSPSDK=$(shell psp-config --pspsdk-path)
PSPBIN = $(PSPSDK)/../bin

CFLAGS = -O2 -G0 -Wall

include $(PSPSDK)/lib/build.mak
