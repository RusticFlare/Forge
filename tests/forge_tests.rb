require 'treetop'
Treetop.load 'PATH_TO/grammar/forge_grammar.tt'

parser = ForgeGrammarParser.new

#tests

anvil = parser.parse("k").content
assert valid_anvil? anvil
assert_equal anvil, {:name=>:sequential, :content=>(ring {:name=>:word, :content=>"k", :release=>1.0, :mods=>[]})}
apply_mods anvil, false
assert valid_anvil? anvil
assert_equal anvil, {:name=>:sequential, :content=>(ring {:name=>:word, :content=>"k", :release=>1.0, :mods=>[]})}
plan = []
plan_data_structure anvil, 0.0, plan
assert valid_forge_plan? plan
assert_equal plan, [{:time=>0.0, :actions=>[{:name=>:word, :content=>"k", :release=>1.0, :mods=>[]}]}]

anvil = parser.parse("45").content
assert valid_anvil? anvil
assert_equal anvil, {:name=>:sequential, :content=>(ring {:name=>:note, :content=>45.0, :release=>1.0, :mods=>[]})}
apply_mods anvil, false
assert valid_anvil? anvil
assert_equal anvil, {:name=>:sequential, :content=>(ring {:name=>:note, :content=>45.0, :release=>1.0, :mods=>[]})}
plan = []
plan_data_structure anvil, 0.0, plan
assert valid_forge_plan? plan
assert_equal plan, [{:time=>0.0, :actions=>[{:name=>:note, :content=>45.0, :release=>1.0, :mods=>[]}]}]

anvil = parser.parse(":drum_heavy_kick").content
assert valid_anvil? anvil
assert_equal anvil, {:name=>:sequential, :content=>(ring {:name=>:sym, :content=>:drum_heavy_kick, :release=>1.0, :mods=>[]})}
apply_mods anvil, false
assert valid_anvil? anvil
assert_equal anvil, {:name=>:sequential, :content=>(ring {:name=>:sym, :content=>:drum_heavy_kick, :release=>1.0, :mods=>[]})}
plan = []
plan_data_structure anvil, 0.0, plan
assert valid_forge_plan? plan
assert_equal plan, [{:time=>0.0, :actions=>[{:name=>:sym, :content=>:drum_heavy_kick, :release=>1.0, :mods=>[]}]}]

anvil = parser.parse("~").content
assert valid_anvil? anvil
assert_equal anvil, {:name=>:sequential, :content=>(ring {:name=>:silence, :release=>1.0, :mods=>[]})}
apply_mods anvil, false
assert valid_anvil? anvil
assert_equal anvil, {:name=>:sequential, :content=>(ring {:name=>:silence, :release=>1.0, :mods=>[]})}
plan = []
plan_data_structure anvil, 0.0, plan
assert valid_forge_plan? plan
assert_equal plan, []

anvil = parser.parse("45").content
assert valid_anvil? anvil
assert_equal anvil, anvil
# puts anvil
apply_mods anvil, false
assert valid_anvil? anvil
assert_equal anvil, anvil
# puts anvil
plan = []
plan_data_structure anvil, 0.0, plan
assert valid_forge_plan? plan
assert_equal plan, plan
# puts plan