require 'test/unit'
require_relative 'classify_code'

class ClassifyCodeTest < Test::Unit::TestCase


  def setup
    @input = 'a00.80.00'
  end


  def test_icd
    assert(get_code_type(@input) == :chop)
  end

end