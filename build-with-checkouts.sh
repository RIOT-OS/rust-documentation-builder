#!/bin/sh
#
# This script is designed to be run inside a checkout of this repository. It
# pulls RIOT from a branch indicated by environment variables, and creates
# checkouts and/or config files locally on demand.

set -e
set -x

RIOT_REPO="${RIOT_REPO:-https://github.com/RIOT-OS/RIOT}"
RIOT_BRANCH="${RIOT_BRANCH:-master}"

git clone "${RIOT_REPO}" -b "${RIOT_BRANCH}"

# TBD: Like RIOT_BRANCH, allow overiding repos / branches for other
# repositories and create patches for those.
cargo update

# Nightly Rust is installed automatically from rust-toolchain.toml, but the
# target is not added the same way.
rustup target add thumbv7em-none-eabihf

# We're not running with RIOT_CI_BUILD to avoid getting *all* the effects of
# things being different, but that also means there is an interactive prompt as
# soon as one starts doing anything SUIT related. Can't set RIOT_CI_BUILD
# because it'd also change the output path, so we emulate a user picking
# 'none' whyen prompted.
echo '0' | make -C RIOT/examples/suit_update suit/genkey

make build-cargo-docs
