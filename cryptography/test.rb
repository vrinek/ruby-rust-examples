require "./cryptography.rb"
require "minitest/autorun"

class Test < Minitest::Test
  def test_md5_of_42
    assert_equal("15d2e6411b3b0f078049aa0a156889f0", Crypto.md5(42))
  end

  def test_md5_of_123
    assert_equal("cbb1747730a326d9587b6c8fdb1d8d84", Crypto.md5(123))
  end

  def test_md5_of_42_str
    assert_equal("15d2e6411b3b0f078049aa0a156889f0", Crypto.md5("42"))
  end

  def test_md5_of_123_str
    assert_equal("cbb1747730a326d9587b6c8fdb1d8d84", Crypto.md5("123"))
  end

  def test_md5_of_secret
    assert_equal("d28d9f5753ab86b22f0f173253bf0e7c", Crypto.md5("secret"))
  end
end
