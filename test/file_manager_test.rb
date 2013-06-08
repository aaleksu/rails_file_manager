require 'test_helper'

class FileManagerTest < Test::Unit::TestCase
#  test "truth" do
#    assert_kind_of Module, FileManager
#end

  def test_to_squawk_prepends_the_word_squawk
    assert_equal "squawk! Hello World", "Hello World".to_squawk
  end
end
