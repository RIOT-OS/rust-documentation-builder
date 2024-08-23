//! # RIOT documentation helper
//!
//! This crate contains neither actual code or documentation, but its build infrastructure is
//! suitable to produce rustdoc output for all crates in the RIOT ecosystem.
//!
//! See the [RIOT documentation on Rust](https://doc.riot-os.org/using-rust.html) for how to use Rust on RIOT.
//! That page contains pointers to all the relevant components.
//!
//! # Rationale for this repository's existence
//!
//! All documented crates depend on `riot-sys` crate, at least transitively -- and that crate
//! requires
//!
//! * a RIOT checkout,
//! * environment configuration as provided by `make info-rust`, and
//! * C2Rust to be installed.
//!
//! As those can not be provided on <https://docs.rs/>, documentation needs to be built using a
//! more manual process, and this repository sets it up.
//!
//! Parts of `riot-wrappers` depend on concrete RIOT modules to be enabled as part of their
//! environment configuration. This repository's Makefile picks a board and modules to maximize the
//! coverage -- at least until a way is found to build `riot-sys` with some maximal configuration.
//! (Which documented items depend on which modules is documented in the produced HTML thanks to
//! the [`doc_auto_cfg` feature](https://github.com/rust-lang/rust/issues/43781)).
#![no_std]
