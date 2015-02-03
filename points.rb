require "fiddle"
require "fiddle/import"

module RustPoint
  extend Fiddle::Importer

  dlload "./libpoints.dylib"

  extern "Point* make_point(int, int)"
  extern "double get_distance(Point*, Point*)"
end

class Point < Struct.new(:x, :y)
  def to_rust
    RustPoint.make_point(x, y)
  end

  def self.distance(p1, p2)
    RustPoint.get_distance(p1.to_rust, p2.to_rust)
  end
end
