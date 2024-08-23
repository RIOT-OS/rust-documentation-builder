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

make build-cargo-docs
