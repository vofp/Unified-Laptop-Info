require File.join(File.dirname(__FILE__), "../src/obj_io/obj_io")
require "test/unit"

class TestIO < Test::Unit::TestCase
    def test_IO
        data = ["test"]
        save_obj("test",data)
        load_obj = load_obj("test")
        assert_equal(data,load_obj)
    end
end