require "./messages.rb"
require "minitest/autorun"

class Test < Minitest::Test
  def test_last_message
    assert_equal("We apologize for the inconvinience.", Messages.last_message)
  end

  def test_male_greeting
    assert_equal("Mister", Messages.greeting("male"))
  end

  def test_female_greeting
    assert_equal("Miss", Messages.greeting("female"))
  end

  def test_other_greeting
    assert_equal("", Messages.greeting("other"))
  end

  def test_format_address
    actual = Messages.format_address("Wall Street", 6, "New York")
    expected ="Wall Street 6, New York"

    assert_equal(expected, actual)
  end
end
