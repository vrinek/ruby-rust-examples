# Quick HOWTO

```
cargo test
ruby test.rb
```

# Dependencies

## Rust

This example was initially written with a Rust 1.0.0 nightly. It should probably work with Rust 1.0.

## Ruby

The Ruby version used was 2.1.5.

# Notes

## Passing strings

Ruby's and Rust's contact point is through C. For this we need to dress them properly on both ends before handling them in code.

## Using external crates

Cargo takes care of the dependencies. One just has to define their dependencies in the `Cargo.toml` and run `cargo build` or `cargo test`.

## Building a dylib via cargo

Take a look at `Cargo.toml` and expecially the `[lib]` section. There, the type and name of the library file is defined. Notice that the library file has a hash appended.

# TODO

* Figure out how cargo calculates the hash that it appends to the lib's filename and if it can be omitted.
