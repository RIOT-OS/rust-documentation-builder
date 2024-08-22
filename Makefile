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
USEMODULE += ztimer_sec
USEMODULE += ztimer_periodic
USEMODULE += bluetil_ad
USEMODULE += suit_transport_coap
USEMODULE += sock_tcp
USEMODULE += sock_udp
USEMODULE += sock_async
USEMODULE += core_thread_flags
USEMODULE += vfs
FEATURES_REQUIRED += periph_adc
FEATURES_REQUIRED += periph_i2c
FEATURES_REQUIRED += periph_spi
FEATURES_REQUIRED += periph_gpio

USEPKG += nimble

# to populate CFLAGS and INCLUDES, which is all we need the RIOT build system for here
include $(RIOTBASE)/Makefile.include

.DEFAULT_GOAL := rustdoc-all

rustdoc-all: build-cargo-docs upload

CARGO_TOOLCHAIN ?= nightly

test:
	CC= CFLAGS= CPPFLAGS= RIOT_CC="${CC}" RIOT_CFLAGS="$(CFLAGS_WITH_MACROS) $(INCLUDES)" cargo +nightly test --target $(CARGO_TARGET) --doc --package riot-wrappers -Z doctest-xcompile

build-cargo-docs: pkg-prepare $(BUILDDEPS)
	CC= CFLAGS= CPPFLAGS= RIOT_CC="${CC}" RIOT_CFLAGS="$(CFLAGS_WITH_MACROS) $(INCLUDES)" cargo +nightly doc --target $(CARGO_TARGET)

upload:
	rsync -vaP --delete bin/${BOARD}/target/${RUST_TARGET}/doc/* prometheus:sites/rustdoc.etonomy.org/

.PHONY: rustdoc-all build-cargo-docs upload
