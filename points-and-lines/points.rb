require "fiddle"
require "fiddle/import"

module RustPoint
  extend Fiddle::Importer

  dlload "./libpoints.dylib"

  extern "Point* make_point(int, int)"
  extern "double get_distance(Point*, Point*)"
end

# Creates a new `Point` struct on Rust's side every time we calculate the distance.
class WorkingPoint < Struct.new(:x, :y)
  def self.distance(p1, p2)
    RustPoint.get_distance(p1.to_rust, p2.to_rust)
  end

  # private

  def to_rust
    RustPoint.make_point(x, y)
  end
end

# Violates Rust's ownership rules and confuses Rust's memory management.
class FailingPoint < Struct.new(:x, :y)
  attr_reader :rust_pointer

  def initialize(*args)
    super
    @rust_pointer = RustPoint.make_point(x, y)
  end

  def self.distance(p1, p2)
    RustPoint.get_distance(p1.rust_pointer, p2.rust_pointer)
  end
end
