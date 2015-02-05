# Quick HOWTO

```
rustc messages.rs --crate-type=dylib
ruby test.rb
```

# Dependencies

## Rust

This example was initially written with a Rust 1.0.0 nightly. It should probably work with Rust 1.0.

## Ruby

The Ruby version used was 2.1.5.

# Notes on passing around strings

Ruby's and Rust's contact point is through C. For this we need to dress them properly on both ends before handling them in code.
