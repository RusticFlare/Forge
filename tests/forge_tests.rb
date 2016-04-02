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
assert_equal anvil, {:name=>:sequential, :content=>(ring {:name=>:note, :content=>[45.0], :release=>1.0, :mods=>[]})}
apply_mods anvil, false
assert valid_anvil? anvil
assert_equal anvil, {:name=>:sequential, :content=>(ring {:name=>:note, :content=>[45.0], :release=>1.0, :mods=>[]})}
plan = []
plan_data_structure anvil, 0.0, plan
assert valid_forge_plan? plan
assert_equal plan, [{:time=>0.0, :actions=>[{:name=>:note, :content=>[45.0], :release=>1.0, :mods=>[]}]}]

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

anvil = parser.parse("45*2").content
assert valid_anvil? anvil
assert_equal anvil, {:name=>:sequential, :content=>(ring {:name=>:note, :content=>[45.0], :release=>1.0, :mods=>[{:name=>:mult, :content=>2}]})}
apply_mods anvil, false
assert valid_anvil? anvil
assert_equal anvil, {:name=>:sequential, :content=>(ring {:name=>:note, :content=>[45.0], :release=>1.0, :mods=>[]}, {:name=>:note, :content=>[45.0], :release=>1.0, :mods=>[]})}
plan = []
plan_data_structure anvil, 0.0, plan
assert valid_forge_plan? plan
assert_equal plan, [{:time=>0.0, :actions=>[{:name=>:note, :content=>[45.0], :release=>0.5, :mods=>[]}]}, {:time=>0.5, :actions=>[{:name=>:note, :content=>[45.0], :release=>0.5, :mods=>[]}]}]

anvil = parser.parse("45(3,5)").content
assert valid_anvil? anvil
assert_equal anvil, {:name=>:sequential, :content=>(ring {:name=>:note, :content=>[45.0], :release=>1.0, :mods=>[{:name=>:spread, :content=>{:ammount=>3, :per=>5}}]})}
apply_mods anvil, false
assert valid_anvil? anvil
assert_equal anvil, {:name=>:sequential, :content=>(ring {:name=>:note, :content=>[45.0], :release=>1.0, :mods=>[]}, {:name=>:silence, :mods=>[]}, {:name=>:note, :content=>[45.0], :release=>1.0, :mods=>[]}, {:name=>:silence, :mods=>[]}, {:name=>:note, :content=>[45.0], :release=>1.0, :mods=>[]})}
plan = []
plan_data_structure anvil, 0.0, plan
assert valid_forge_plan? plan
assert_equal plan, [{:time=>0.0, :actions=>[{:name=>:note, :content=>[45.0], :release=>0.2, :mods=>[]}]}, {:time=>0.4, :actions=>[{:name=>:note, :content=>[45.0], :release=>0.2, :mods=>[]}]}, {:time=>0.8, :actions=>[{:name=>:note, :content=>[45.0], :release=>0.2, :mods=>[]}]}]

anvil = parser.parse("45/2").content
assert valid_anvil? anvil
assert_equal anvil, {:name=>:sequential, :content=>(ring {:name=>:note, :content=>[45.0], :release=>1.0, :mods=>[{:name=>:stretch, :content=>2}]})}
apply_mods anvil, false
assert valid_anvil? anvil
assert_equal anvil, {:name=>:sequential, :content=>(ring {:name=>:timed_parallel, :content=>[{:name=>:sequential, :content=>(ring {:name=>:silence, :mods=>[], :release=>1})}, {:name=>:sequential, :content=>(ring {:name=>:note, :content=>[45.0], :release=>2.0, :mods=>[]}, {:name=>:silence, :mods=>[], :release=>1})}], :index=>0, :release=>1.0, :mods=>[]})}
plan = []
plan_data_structure anvil, 0.0, plan
assert valid_forge_plan? plan
assert_equal plan, [{:time=>0.0, :actions=>[{:name=>:note, :content=>[45.0], :release=>2.0, :mods=>[]}]}]

anvil = parser.parse("[45]").content
assert valid_anvil? anvil
assert_equal anvil, {:name=>:sequential, :content=>(ring {:name=>:parallel, :content=>[{:name=>:sequential, :content=>(ring {:name=>:note, :content=>[45.0], :release=>1.0, :mods=>[]})}], :release=>1.0, :mods=>[]})}
apply_mods anvil, false
assert valid_anvil? anvil
assert_equal anvil, {:name=>:sequential, :content=>(ring {:name=>:parallel, :content=>[{:name=>:sequential, :content=>(ring {:name=>:note, :content=>[45.0], :release=>1.0, :mods=>[]})}], :release=>1.0, :mods=>[]})}
plan = []
plan_data_structure anvil, 0.0, plan
assert valid_forge_plan? plan
assert_equal plan, [{:time=>0.0, :actions=>[{:name=>:note, :content=>[45.0], :release=>1.0, :mods=>[]}]}]

anvil = parser.parse("{45}").content
assert valid_anvil? anvil
assert_equal anvil, {:name=>:sequential, :content=>(ring {:name=>:timed_parallel, :content=>[{:name=>:sequential, :content=>(ring {:name=>:note, :content=>[45.0], :release=>1.0, :mods=>[]})}], :index=>0, :release=>1.0, :mods=>[]})}
apply_mods anvil, false
assert valid_anvil? anvil
assert_equal anvil, {:name=>:sequential, :content=>(ring {:name=>:timed_parallel, :content=>[{:name=>:sequential, :content=>(ring {:name=>:note, :content=>[45.0], :release=>1.0, :mods=>[]})}], :index=>0, :release=>1.0, :mods=>[]})}
plan = []
plan_data_structure anvil, 0.0, plan
assert valid_forge_plan? plan
assert_equal plan, [{:time=>0.0, :actions=>[{:name=>:note, :content=>[45.0], :release=>1.0, :mods=>[]}]}]

anvil = parser.parse("{45/3, 50/2}").content
assert valid_anvil? anvil
assert_equal anvil, {:name=>:sequential, :content=>(ring {:name=>:timed_parallel, :content=>[{:name=>:sequential, :content=>(ring {:name=>:note, :content=>[45.0], :release=>1.0, :mods=>[{:name=>:stretch, :content=>3}]})}, {:name=>:sequential, :content=>(ring {:name=>:note, :content=>[50.0], :release=>1.0, :mods=>[{:name=>:stretch, :content=>2}]})}], :index=>0, :release=>1.0, :mods=>[]})}
apply_mods anvil, false
assert valid_anvil? anvil
assert_equal anvil, {:name=>:sequential, :content=>(ring {:name=>:timed_parallel, :content=>[{:name=>:sequential, :content=>(ring {:name=>:timed_parallel, :content=>[{:name=>:sequential, :content=>(ring {:name=>:silence, :mods=>[], :release=>1})}, {:name=>:sequential, :content=>(ring {:name=>:note, :content=>[45.0], :release=>3.0, :mods=>[]}, {:name=>:silence, :mods=>[], :release=>1}, {:name=>:silence, :mods=>[], :release=>1})}], :index=>0, :release=>1.0, :mods=>[]})}, {:name=>:sequential, :content=>(ring {:name=>:note, :content=>[50.0], :release=>2.0, :mods=>[]}, {:name=>:silence, :mods=>[], :release=>1})}], :index=>0, :release=>1.0, :mods=>[]})}
plan = []
plan_data_structure anvil, 0.0, plan
assert valid_forge_plan? plan
assert_equal plan, [{:time=>0.0, :actions=>[{:name=>:note, :content=>[45.0], :release=>3.0, :mods=>[]}, {:name=>:note, :content=>[50.0], :release=>2.0, :mods=>[]}]}]

anvil = parser.parse("[45, 50]").content
assert valid_anvil? anvil
assert_equal anvil, {:name=>:sequential, :content=>(ring {:name=>:parallel, :content=>[{:name=>:sequential, :content=>(ring {:name=>:note, :content=>[45.0], :release=>1.0, :mods=>[]})}, {:name=>:sequential, :content=>(ring {:name=>:note, :content=>[50.0], :release=>1.0, :mods=>[]})}], :release=>1.0, :mods=>[]})}
apply_mods anvil, false
assert valid_anvil? anvil
assert_equal anvil, {:name=>:sequential, :content=>(ring {:name=>:parallel, :content=>[{:name=>:sequential, :content=>(ring {:name=>:note, :content=>[45.0], :release=>1.0, :mods=>[]})}, {:name=>:sequential, :content=>(ring {:name=>:note, :content=>[50.0], :release=>1.0, :mods=>[]})}], :release=>1.0, :mods=>[]})}
plan = []
plan_data_structure anvil, 0.0, plan
assert valid_forge_plan? plan
assert_equal plan, [{:time=>0.0, :actions=>[{:name=>:note, :content=>[45.0], :release=>1.0, :mods=>[]}, {:name=>:note, :content=>[50.0], :release=>1.0, :mods=>[]}]}]

anvil = parser.parse("[45*2]*2").content
assert valid_anvil? anvil
assert_equal anvil, {:name=>:sequential, :content=>(ring {:name=>:parallel, :content=>[{:name=>:sequential, :content=>(ring {:name=>:note, :content=>[45.0], :release=>1.0, :mods=>[{:name=>:mult, :content=>2}]})}], :release=>1.0, :mods=>[{:name=>:mult, :content=>2}]})}
apply_mods anvil, false
assert valid_anvil? anvil
assert_equal anvil, {:name=>:sequential, :content=>(ring {:name=>:parallel, :content=>[{:name=>:sequential, :content=>(ring {:name=>:note, :content=>[45.0], :release=>1.0, :mods=>[]}, {:name=>:note, :content=>[45.0], :release=>1.0, :mods=>[]})}], :release=>1.0, :mods=>[]}, {:name=>:parallel, :content=>[{:name=>:sequential, :content=>(ring {:name=>:note, :content=>[45.0], :release=>1.0, :mods=>[]}, {:name=>:note, :content=>[45.0], :release=>1.0, :mods=>[]})}], :release=>1.0, :mods=>[]})}
plan = []
plan_data_structure anvil, 0.0, plan
assert valid_forge_plan? plan
assert_equal plan, [{:time=>0.0, :actions=>[{:name=>:note, :content=>[45.0], :release=>0.25, :mods=>[]}]}, {:time=>0.25, :actions=>[{:name=>:note, :content=>[45.0], :release=>0.25, :mods=>[]}]}, {:time=>0.5, :actions=>[{:name=>:note, :content=>[45.0], :release=>0.25, :mods=>[]}]}, {:time=>0.75, :actions=>[{:name=>:note, :content=>[45.0], :release=>0.25, :mods=>[]}]}]

anvil = parser.parse("{45*2}*2").content
assert valid_anvil? anvil
assert_equal anvil, {:name=>:sequential, :content=>(ring {:name=>:timed_parallel, :content=>[{:name=>:sequential, :content=>(ring {:name=>:note, :content=>[45.0], :release=>1.0, :mods=>[{:name=>:mult, :content=>2}]})}], :index=>0, :release=>1.0, :mods=>[{:name=>:mult, :content=>2}]})}
apply_mods anvil, false
assert valid_anvil? anvil
assert_equal anvil, {:name=>:sequential, :content=>(ring {:name=>:timed_parallel, :content=>[{:name=>:sequential, :content=>(ring {:name=>:note, :content=>[45.0], :release=>1.0, :mods=>[]}, {:name=>:note, :content=>[45.0], :release=>1.0, :mods=>[]})}], :index=>0, :release=>1.0, :mods=>[]}, {:name=>:timed_parallel, :content=>[{:name=>:sequential, :content=>(ring {:name=>:note, :content=>[45.0], :release=>1.0, :mods=>[]}, {:name=>:note, :content=>[45.0], :release=>1.0, :mods=>[]})}], :index=>0, :release=>1.0, :mods=>[]})}
plan = []
plan_data_structure anvil, 0.0, plan
assert valid_forge_plan? plan
assert_equal plan, [{:time=>0.0, :actions=>[{:name=>:note, :content=>[45.0], :release=>0.25, :mods=>[]}]}, {:time=>0.25, :actions=>[{:name=>:note, :content=>[45.0], :release=>0.25, :mods=>[]}]}, {:time=>0.5, :actions=>[{:name=>:note, :content=>[45.0], :release=>0.25, :mods=>[]}]}, {:time=>0.75, :actions=>[{:name=>:note, :content=>[45.0], :release=>0.25, :mods=>[]}]}]

anvil = parser.parse("45-2 ~").content
assert valid_anvil? anvil
assert_equal anvil, {:name=>:sequential, :content=>(ring {:name=>:note, :content=>[45.0], :release=>1.0, :mods=>[{:name=>:release, :content=>2.0}]}, {:name=>:silence, :release=>1.0, :mods=>[]})}
apply_mods anvil, false
assert valid_anvil? anvil
assert_equal anvil, {:name=>:sequential, :content=>(ring {:name=>:note, :content=>[45.0], :release=>2.0, :mods=>[]}, {:name=>:silence, :release=>1.0, :mods=>[]})}
plan = []
plan_data_structure anvil, 0.0, plan
assert valid_forge_plan? plan
assert_equal plan, [{:time=>0.0, :actions=>[{:name=>:note, :content=>[45.0], :release=>1.0, :mods=>[]}]}]

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