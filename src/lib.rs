//! <!-- This documentation serves as the entry point of the produced documentation. For the why
//! and how of this crate, see
//! https://github.com/RIOT-OS/rust-documentation-builder/blob/main/README.md -->
//!
//! # RIOT Rust documentation
//!
//! This is the entry point for the documentation of Rust functions for RIOT as built by rustdoc.
//!
//! For how to use Rust on RIOT in general, see the [RIOT documentation on
//! Rust](https://doc.riot-os.org/using-rust.html).
//!
//! Relevant crates are:
//!
//! * [riot-wrappers](riot_wrappers) creates safe idiomatic Rust wrappers for everyday use.
//! * [riot-sys](riot_sys) maps the raw RIOT functions to unsafe Rust equivalents from bindgen.
//! * Several [riot-module-examples](https://gitlab.com/etonomy/riot-module-examples/) are a mix of
//!   actual example code and convenient tools:
//!   * [riot-shell-commands](riot_shell_commands) implements the `sleep`, `ps` and other shell
//!     commands in Rust.
//!   * [riot-coap-handler-demos](riot_coap_handler_demos) implements the `ps` but also file system
//!     access and SAUL access over CoAP.
//!   * [embassy-executor-riot](embassy_executor_riot) provides an executor for asynchronous
//!     functions based on Embassy.
#![no_std]

extern crate rust_riotmodules;
