require "fiddle"
require "fiddle/import"
require "minitest/autorun"

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
end

def make_point(x, y)
  Point.new(x, y)
end

def get_distance(p1, p2)
  RustPoint.get_distance(p1.to_rust, p2.to_rust)
end

$p0 = make_point(0,0)
$p1 = make_point(1,2)
$p2 = make_point(3,4)

class Test < Minitest::Test
  def test_no_distance
    l0 = get_distance($p1, $p1)
    assert(l0 == 0)
  end

  def test_some_distance1
    l1 = get_distance(make_point(2,3), make_point(12,0))
    assert(l1 > 10 && l1 < 11)
  end

  def test_some_distance2
    l2 = get_distance(make_point(2,0), make_point(12,0))
    assert(l2 == 10.0)
  end

  def test_some_distance3
    l3 = get_distance($p1, $p2)
    l4 = get_distance($p2, $p1)
    assert(l3 == l4)
  end

  def test_some_distance5
    l5 = get_distance(make_point(2,0), make_point(12,0))
    assert(l5 == 10.0)
  end

  def test_some_distance6
    l6 = get_distance(make_point(2,0), $p2)
    assert(l6 > 4 && l6 < 5)
  end

  def test_some_distance7
    l7 = get_distance(make_point(2,0), $p1)
    assert(l7 > 2 && l7 < 3)
  end
end
