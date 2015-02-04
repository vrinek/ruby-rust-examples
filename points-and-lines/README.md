# Quick HOWTO

```
rustc points.rs --crate-type=dylib
ruby test.rb
```

# Dependencies

## Rust

This example was initially written with a Rust 1.0.0 nightly. It should probably work with Rust 1.0.

## Ruby

The Ruby version used was 2.1.5.

# Notes on the Point implementations

## FailingPoint

In this implementation, we prepare a `Point` on Rust's side upon initialization and pass it to Rust's `get_distance` function whenever needed. Unfortunately this violates Rust's ownership rules and thus we end up with the memory space our pointer is pointing at getting reused since Rust thinks it's garbage.

## WorkingPoint

This way, we hide the pointer-handling from the user and prepare the structs on Rust's side only when we are ready to pass them to the `get_distance` function for the calculations.
