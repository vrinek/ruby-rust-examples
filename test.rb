require './points.rb'

$p0 = Point.new(0, 0)
$p1 = Point.new(1, 2)
$p2 = Point.new(3, 4)

class Test < Minitest::Test
  def test_no_distance
    distance = Point.distance($p1, $p1)

    assert_equal(0, distance)
  end

  def test_some_distance1
    distance = Point.distance(Point.new(2, 3), Point.new(12, 0))

    assert(distance > 10 && distance < 11)
  end

  def test_some_distance2
    distance = Point.distance(Point.new(2, 0), Point.new(12, 0))

    assert_equal(10.0, distance)
  end

  def test_some_distance3
    distance1 = Point.distance($p1, $p2)
    distance2 = Point.distance($p2, $p1)

    assert_equal(distance1, distance2)
  end

  def test_some_distance5
    distance = Point.distance(Point.new(2, 0), Point.new(12, 0))

    assert_equal(10.0, distance)
  end

  def test_some_distance6
    distance = Point.distance(Point.new(2, 0), $p2)

    assert(distance > 4 && distance < 5)
  end

  def test_some_distance7
    distance = Point.distance(Point.new(2, 0), $p1)

    assert(distance > 2 && distance < 3)
  end
end

