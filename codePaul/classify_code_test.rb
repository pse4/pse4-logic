require 'test/unit'
require 'minitest/reporters'
require_relative 'classify_code'

MiniTest::Reporters.use!

class ClassifyCodeTest < Test::Unit::TestCase

  def setup
    @chop1 = '00.4D'
    @chop2 = '89.d3.5C'
    @chop3 = '99.B6.11'

    @icd1 = 'a66.0'
    @icd2 = 'K58'
    @icd3 = 'Z09.22'

    @unknown1 = 'A'
    @unknown2 = 'c0.4d'
    @unknown3 = 'z45.P'
    @unknown4 = 'g3.66.66'
    @unknown5 = '999.b6.11'
    @unknown6 = 'ss5.22'
  end


  def test_chop
    assert(get_code_type(@chop1) == :chop)
    assert(get_code_type(@chop2) == :chop)
    assert(get_code_type(@chop3) == :chop)
  end

  def test_icd
    assert(get_code_type(@icd1) == :icd)
    assert(get_code_type(@icd2) == :icd)
    assert(get_code_type(@icd3) == :icd)
  end

  def test_unknown
    assert(get_code_type(@unknown1) == :unknown)
    assert(get_code_type(@unknown2) == :unknown)
    assert(get_code_type(@unknown3) == :unknown)
    assert(get_code_type(@unknown4) == :unknown)
    assert(get_code_type(@unknown5) == :unknown)
    assert(get_code_type(@unknown6) == :unknown)
  end

end