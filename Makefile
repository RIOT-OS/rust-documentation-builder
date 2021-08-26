RIOTBASE = ./RIOT

# just to make the build tools happy
APPLICATION = documentation
# pick one on which all the required modules can actually be enabled
BOARD = nrf52840dongle
CARGO_TARGET = thumbv7em-none-eabihf
TOOLCHAIN = llvm
DEVELHELP = 1

USEMODULE += gnrc
USEMODULE += gnrc_ipv6
USEMODULE += gcoap
USEMODULE += shell
USEMODULE += shell_commands
USEMODULE += ps
USEMODULE += saul_default
USEMODULE += ztimer_usec
USEMODULE += ztimer_msec
USEMODULE += bluetil_ad
USEMODULE += suit_transport_coap
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
	rsync -vaP --delete ./target/thumbv7em-none-eabihf/doc/* prometheus:sites/rustdoc.etonomy.org/

.PHONY: rustdoc-all build-cargo-docs upload
