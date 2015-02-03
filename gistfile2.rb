require "fiddle"
require "fiddle/import"
require "minitest/autorun"

module RustPoint
  extend Fiddle::Importer

  dlload "./libpoints.dylib"

  extern "Point* make_point(int, int)"
  extern "double get_distance(Point*, Point*)"
end

class Test < Minitest::Test
  i_suck_and_my_tests_are_order_dependent!

  def test_1
    p1 = RustPoint.make_point(2,3)
    p2 = RustPoint.make_point(12,0)
    distance = RustPoint.get_distance(p1, p2)

    assert(distance > 10 && distance < 11)
  end

  def test_2
    point = RustPoint.make_point(3,4)
    distance = RustPoint.get_distance(point, point)

    assert(distance == 0)
  end

  # same as test_1
  def test_3
    p1 = RustPoint.make_point(2,3)
    p2 = RustPoint.make_point(12,0)
    distance = RustPoint.get_distance(p1, p2)

    assert(distance > 10 && distance < 11)
  end
end
