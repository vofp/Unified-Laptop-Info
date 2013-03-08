require File.join(File.dirname(__FILE__), "../src/parse/newegg")
require File.join(File.dirname(__FILE__), "../src/parse/walmart")
require File.join(File.dirname(__FILE__), "../src/parse/organizer")
require "test/unit"

$o_specs_newegg = {:memory_size=>[["4"], ["4"]], :screen_size=>[["14", "\""], ["14", "\""]], :cpu_speed=>[["1.70"], ["2.6"]], :resolution=>[["1366", "768"]], :hd_size=>[["500", "gb"], ["24", "gb"], ["500", "gb"], ["24", "gb"]]}
$o_specs_walmart = {:memory_size=>[["4"], ["4"]], :screen_size=>[["14.0", "inch"]], :cpu_speed=>[["1.70"], ["2.60"]], :resolution=>[["1366", "768"]], :hd_size=>[["24", "gb"]]}
$o_specs_rakuten = {:resolution=>[["1366", "768"]], :hd_size=>[["500", "gb"], ["24", "gb"]], :memory_size=>[["4"]], :screen_size=>[["14.1", "\""]], :cpu_speed=>[["1.70"]]}
$o_c_spec = {
    :screen_size=>{ 
        "14.1\""=>{:count=>1, :votes=>0, :data=>["14.1", "\""], :sort=>14.1},
        "14.0\""=>{:count=>3, :votes=>0, :data=>["14", "\""], :sort=>14.0}},
    :cpu_speed=>{
        "1.70GHz"=>{:count=>3, :votes=>0, :data=>["1.70"], :sort=>1.7},
        "2.60GHz"=>{:count=>2, :votes=>0, :data=>["2.6"], :sort=>2.6}},
    :resolution=>{
        "1366 x 768"=>{:count=>3, :votes=>0, :data=>["1366", "768"], :sort=>1366}},
    :hd_size=>{
        "500GB"=>{:count=>3, :votes=>0, :data=>["500", "gb"], :sort=>500},
        "24GB"=>{:count=>4, :votes=>0, :data=>["24", "gb"], :sort=>24}},
    :memory_size=>{
        "4GB"=>{:count=>5, :votes=>0, :data=>["4"], :sort=>4}}
}




class TestOrganizer < Test::Unit::TestCase
    def test_combine
        c_spec = new_complete_spec
        output = combine(c_spec, $o_specs_newegg, $o_specs_walmart, $o_specs_rakuten)
        assert_equal($o_c_spec, output)
    end
end
