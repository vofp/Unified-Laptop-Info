
require File.join(File.dirname(__FILE__), '../src/parse/common')
require "test/unit"


class TestParseCpuSpeed < Test::Unit::TestCase

    def test_single_input()
        assert_equal([["3.6"]],parse_detail(:cpu_speed,"3.6Ghz"))
        assert_equal([["2.66"]],parse_detail(:cpu_speed,"2.66Ghz"))
        assert_equal([["1.6"]],parse_detail(:cpu_speed,"1.6 Ghz"))
    end
    def test_multi_input()
        assert_equal([["3.6"],["1.12"]], parse_detail(:cpu_speed,"3.6Ghz","1.12ghz"))
    end

    def test_invalid_input()
        assert_equal([], parse_detail(:cpu_speed,""))
    end

end

class TestParseResolution < Test::Unit::TestCase

    def test_single_input()
        assert_equal([["10", "18"]],parse_detail(:resolution,"10x18"))
        assert_equal([["1080", "1800"]],parse_detail(:resolution,"1080 x 1800"))
        assert_equal([["1900", "800"]],parse_detail(:resolution,"1900x 800"))
    end

    def test_invalid_input()
        assert_equal([], parse_detail(:resolution,""))
    end

end

class TestParseHdSize < Test::Unit::TestCase

    def test_single_input()
        assert_equal([["10", "gb"]],parse_detail(:hd_size,"10Gb"))
        assert_equal([["10", "tb"]],parse_detail(:hd_size,"10tb"))
        assert_equal([["500", "gb"]],parse_detail(:hd_size,"500 gb"))
    end

    def test_multi_input()
        assert_equal([["10","gb"],["10","tb"]], parse_detail(:hd_size,"10Gb","10tb"))
    end

    def test_invalid_input()
        assert_equal([], parse_detail(:hd_size,""))
    end

end

class TestParseMemorySize < Test::Unit::TestCase

    def test_single_input()
        assert_equal([["10"]],parse_detail(:memory_size,"10Gb"))
        assert_equal([["1"]],parse_detail(:memory_size,"1gb"))
        assert_equal([["500"]],parse_detail(:memory_size,"500 gb"))
    end

    def test_invalid_input()
        assert_equal([], parse_detail(:memory_size,""))
    end

end

class TestParseScreenSize < Test::Unit::TestCase

    def test_single_input()
        assert_equal([["10.1", "\""]],parse_detail(:screen_size,"10.1\""))
        assert_equal([["15.6", "\""]],parse_detail(:screen_size,"15.6 \""))
        assert_equal([["24", "inch"]],parse_detail(:screen_size,"24inch"))
        assert_equal([["2", "inch"]],parse_detail(:screen_size,"2 inch"))
    end

    def test_invalid_input()
        assert_equal([], parse_detail(:screen_size,""))
    end

end