//! # RIOT documentation helper
//!
//! This crate contains neither actual code or documentation, but its build infrastructure is
//! suitable to produce rustdoc output for all crates in the RIOT ecosystem.
//!
//! If you are new to Rust on RIOT, your best starting point are [the
//! examples](https://gitlab.com/etonomy/riot-examples/), which also contain any setup instructions
//! you may need.
//!
//! If you are looking for documentation on individual crates, you may want to see:
//!
//! * [riot-sys](riot_sys), which maps the raw RIOT functions to unsafe Rust equivalents
//! * [riot-wrappers](riot_wrappers), which cretes safe idiomatic Rust wrappers around the above,
//!   and implements interoperability traits on them
//! * [riot-shell-commands](riot_shell_commands) and
//!   [riot-coap-handler-demos](riot_coap_handler_demos), which are libraries used in the
//!   [examples](https://gitlab.com/etonomy/riot-examples/) collection
//!
//! ---
//!
//! The trouble with RIOT crates is that they are practically used with a RIOT checkout present,
//! and even are called from inside RIOT's build system. Thus, any crate that wants documentation
//! built in the general way (at <https://docs.rs/>) would need special casing in its build system,
//! and ship some parts of RIOT to even build the riot-sys crate it depends on. Furthermore, that
//! build process also includes having `c2rust` installed locally, which in term requires a
//! particular nightly toolchain.
//!
//! A related issue is that both riot-sys and riot-bindgen have parts of their code not conditional
//! on cargo-enabled features, but on the capabilities ("modules" and "provides") of the RIOT
//! application and board. (That mechanism may change in future, but even if the conditional parts
//! were enabled using features, builds would fail when the code parts lack their implementation's
//! bindgen and C2Rust generated backing functions). Thus, this crate makes up a board setup that
//! makes all of riot-wrappers' features available.
#![no_std]
