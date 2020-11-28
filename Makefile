RIOTBASE = ./RIOT

# just to make the build tools happy
APPLICATION = documentation
# pick one on which all the required modules can actually be enabled
BOARD = nrf52840dongle
CARGO_TARGET = thumbv7em-none-eabihf
TOOLCHAIN = llvm
DEVELHELP = 1

USEMODULE += shell
USEMODULE += shell_commands
USEMODULE += ps
USEMODULE += saul_default
USEMODULE += ztimer_usec
USEMODULE += ztimer_msec
USEMODULE += bluetil_ad
FEATURES_REQUIRED += periph_adc
FEATURES_REQUIRED += periph_i2c
FEATURES_REQUIRED += periph_spi
FEATURES_REQUIRED += periph_gpio

USEPKG += nimble

# to populate CFLAGS and INCLUDES, which is all we need the RIOT build system for here
include $(RIOTBASE)/Makefile.include

.DEFAULT_GOAL := rustdoc-all

rustdoc-all: build-cargo-docs upload

build-cargo-docs: pkg-prepare $(BUILDDEPS)
	CC= CFLAGS= CPPFLAGS= RIOT_CC="${CC}" RIOT_CFLAGS="$(CFLAGS_WITH_MACROS) $(INCLUDES)" cargo +nightly doc --target $(CARGO_TARGET)

upload:
	# "already mounted" is also an error
	gio mount ftps://rustdoc.etonomy.org/ || true
	# check for actual success of the above
	gio list ftps://rustdoc.etonomy.org/ >/dev/null

	[ -e /run/user/1000/gvfs/ftps:host=rustdoc.etonomy.org ]

	# Given we can't set time stamps on this server, and checksumming would mean
	# getting the whole file, we trust that any changes are reflected in size changes
	#
	# Doing riot_wrappers first because those are the most active and provide
	# quickly checkable results as opposed to the possibly slow tail
	rsync -vr --ignore-times --perms ./target/thumbv7em-none-eabihf/doc/riot_wrappers /run/user/1000/gvfs/ftps:host=rustdoc.etonomy.org/
	rsync -vr --ignore-times --perms ./target/thumbv7em-none-eabihf/doc/riot_* /run/user/1000/gvfs/ftps:host=rustdoc.etonomy.org/

.PHONY: rustdoc-all build-cargo-docs upload
