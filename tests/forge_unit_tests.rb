require 'treetop'
Treetop.load 'PATH_TO/grammar/forge_grammar.tt'

parser = ForgeGrammarParser.new

#tests

anvil = parser.parse("k").content
assert valid_anvil? anvil
assert_equal anvil, {:type=>:sequential, :content=>(ring {:type=>:word, :content=>"k", :release=>1.0, :mods=>[]})}
apply_mods anvil, false
assert valid_anvil? anvil
assert_equal anvil, {:type=>:sequential, :content=>(ring {:type=>:word, :content=>"k", :release=>1.0, :mods=>[]})}
plan = []
plan_data_structure anvil, 0.0, plan
assert valid_forge_plan? plan
assert_equal plan, [{:time=>0.0, :actions=>[{:type=>:word, :content=>"k", :release=>1.0, :mods=>[]}]}]

anvil = parser.parse("45").content
assert valid_anvil? anvil
assert_equal anvil, {:type=>:sequential, :content=>(ring {:type=>:note, :content=>[{:note=>45.0}], :release=>1.0, :mods=>[]})}
apply_mods anvil, false
assert valid_anvil? anvil
assert_equal anvil, {:type=>:sequential, :content=>(ring {:type=>:note, :content=>[{:note=>45.0}], :release=>1.0, :mods=>[]})}
plan = []
plan_data_structure anvil, 0.0, plan
assert valid_forge_plan? plan
assert_equal plan, [{:time=>0.0, :actions=>[{:type=>:note, :content=>[{:note=>45.0}], :release=>1.0, :mods=>[]}]}]

anvil = parser.parse(":drum_heavy_kick").content
assert valid_anvil? anvil
assert_equal anvil, {:type=>:sequential, :content=>(ring {:type=>:sym, :content=>:drum_heavy_kick, :release=>1.0, :mods=>[]})}
apply_mods anvil, false
assert valid_anvil? anvil
assert_equal anvil, {:type=>:sequential, :content=>(ring {:type=>:sym, :content=>:drum_heavy_kick, :release=>1.0, :mods=>[]})}
plan = []
plan_data_structure anvil, 0.0, plan
assert valid_forge_plan? plan
assert_equal plan, [{:time=>0.0, :actions=>[{:type=>:sym, :content=>:drum_heavy_kick, :release=>1.0, :mods=>[]}]}]

anvil = parser.parse("~").content
assert valid_anvil? anvil
assert_equal anvil, {:type=>:sequential, :content=>(ring {:type=>:silence, :release=>1.0, :mods=>[]})}
apply_mods anvil, false
assert valid_anvil? anvil
assert_equal anvil, {:type=>:sequential, :content=>(ring {:type=>:silence, :release=>1.0, :mods=>[]})}
plan = []
plan_data_structure anvil, 0.0, plan
assert valid_forge_plan? plan
assert_equal plan, []

anvil = parser.parse("45*2").content
assert valid_anvil? anvil
assert_equal anvil, {:type=>:sequential, :content=>(ring {:type=>:note, :content=>[{:note=>45.0}], :release=>1.0, :mods=>[{:type=>:mult, :content=>2}]})}
apply_mods anvil, false
assert valid_anvil? anvil
assert_equal anvil, {:type=>:sequential, :content=>(ring {:type=>:note, :content=>[{:note=>45.0}], :release=>1.0, :mods=>[]}, {:type=>:note, :content=>[{:note=>45.0}], :release=>1.0, :mods=>[]})}
plan = []
plan_data_structure anvil, 0.0, plan
assert valid_forge_plan? plan
assert_equal plan, [{:time=>0.0, :actions=>[{:type=>:note, :content=>[{:note=>45.0}], :release=>0.5, :mods=>[]}]}, {:time=>0.5, :actions=>[{:type=>:note, :content=>[{:note=>45.0}], :release=>0.5, :mods=>[]}]}]

anvil = parser.parse("45(3,5)").content
assert valid_anvil? anvil
assert_equal anvil, {:type=>:sequential, :content=>(ring {:type=>:note, :content=>[{:note=>45.0}], :release=>1.0, :mods=>[{:type=>:spread, :content=>{:ammount=>3, :per=>5}}]})}
apply_mods anvil, false
assert valid_anvil? anvil
assert_equal anvil, {:type=>:sequential, :content=>(ring {:type=>:note, :content=>[{:note=>45.0}], :release=>1.0, :mods=>[]}, {:type=>:silence, :mods=>[]}, {:type=>:note, :content=>[{:note=>45.0}], :release=>1.0, :mods=>[]}, {:type=>:silence, :mods=>[]}, {:type=>:note, :content=>[{:note=>45.0}], :release=>1.0, :mods=>[]})}
plan = []
plan_data_structure anvil, 0.0, plan
assert valid_forge_plan? plan
assert_equal plan, [{:time=>0.0, :actions=>[{:type=>:note, :content=>[{:note=>45.0}], :release=>0.2, :mods=>[]}]}, {:time=>0.4, :actions=>[{:type=>:note, :content=>[{:note=>45.0}], :release=>0.2, :mods=>[]}]}, {:time=>0.8, :actions=>[{:type=>:note, :content=>[{:note=>45.0}], :release=>0.2, :mods=>[]}]}]

anvil = parser.parse("45/2").content
assert valid_anvil? anvil
assert_equal anvil, {:type=>:sequential, :content=>(ring {:type=>:note, :content=>[{:note=>45.0}], :release=>1.0, :mods=>[{:type=>:stretch, :content=>2}]})}
apply_mods anvil, false
assert valid_anvil? anvil
assert_equal anvil, {:type=>:sequential, :content=>(ring {:type=>:timed_parallel, :content=>[{:type=>:sequential, :content=>(ring {:type=>:silence, :mods=>[], :release=>1})}, {:type=>:sequential, :content=>(ring {:type=>:note, :content=>[{:note=>45.0}], :release=>2.0, :mods=>[]}, {:type=>:silence, :mods=>[], :release=>1})}], :index=>0, :release=>1.0, :mods=>[]})}
plan = []
plan_data_structure anvil, 0.0, plan
assert valid_forge_plan? plan
assert_equal plan, [{:time=>0.0, :actions=>[{:type=>:note, :content=>[{:note=>45.0}], :release=>2.0, :mods=>[]}]}]

anvil = parser.parse("[45]").content
assert valid_anvil? anvil
assert_equal anvil, {:type=>:sequential, :content=>(ring {:type=>:parallel, :content=>[{:type=>:sequential, :content=>(ring {:type=>:note, :content=>[{:note=>45.0}], :release=>1.0, :mods=>[]})}], :release=>1.0, :mods=>[]})}
apply_mods anvil, false
assert valid_anvil? anvil
assert_equal anvil, {:type=>:sequential, :content=>(ring {:type=>:parallel, :content=>[{:type=>:sequential, :content=>(ring {:type=>:note, :content=>[{:note=>45.0}], :release=>1.0, :mods=>[]})}], :release=>1.0, :mods=>[]})}
plan = []
plan_data_structure anvil, 0.0, plan
assert valid_forge_plan? plan
assert_equal plan, [{:time=>0.0, :actions=>[{:type=>:note, :content=>[{:note=>45.0}], :release=>1.0, :mods=>[]}]}]

anvil = parser.parse("{45}").content
assert valid_anvil? anvil
assert_equal anvil, {:type=>:sequential, :content=>(ring {:type=>:timed_parallel, :content=>[{:type=>:sequential, :content=>(ring {:type=>:note, :content=>[{:note=>45.0}], :release=>1.0, :mods=>[]})}], :index=>0, :release=>1.0, :mods=>[]})}
apply_mods anvil, false
assert valid_anvil? anvil
assert_equal anvil, {:type=>:sequential, :content=>(ring {:type=>:timed_parallel, :content=>[{:type=>:sequential, :content=>(ring {:type=>:note, :content=>[{:note=>45.0}], :release=>1.0, :mods=>[]})}], :index=>0, :release=>1.0, :mods=>[]})}
plan = []
plan_data_structure anvil, 0.0, plan
assert valid_forge_plan? plan
assert_equal plan, [{:time=>0.0, :actions=>[{:type=>:note, :content=>[{:note=>45.0}], :release=>1.0, :mods=>[]}]}]

anvil = parser.parse("{45/3, 50/2}").content
assert valid_anvil? anvil
assert_equal anvil, {:type=>:sequential, :content=>(ring {:type=>:timed_parallel, :content=>[{:type=>:sequential, :content=>(ring {:type=>:note, :content=>[{:note=>45.0}], :release=>1.0, :mods=>[{:type=>:stretch, :content=>3}]})}, {:type=>:sequential, :content=>(ring {:type=>:note, :content=>[{:note=>50.0}], :release=>1.0, :mods=>[{:type=>:stretch, :content=>2}]})}], :index=>0, :release=>1.0, :mods=>[]})}
apply_mods anvil, false
assert valid_anvil? anvil
assert_equal anvil, {:type=>:sequential, :content=>(ring {:type=>:timed_parallel, :content=>[{:type=>:sequential, :content=>(ring {:type=>:timed_parallel, :content=>[{:type=>:sequential, :content=>(ring {:type=>:silence, :mods=>[], :release=>1})}, {:type=>:sequential, :content=>(ring {:type=>:note, :content=>[{:note=>45.0}], :release=>3.0, :mods=>[]}, {:type=>:silence, :mods=>[], :release=>1}, {:type=>:silence, :mods=>[], :release=>1})}], :index=>0, :release=>1.0, :mods=>[]})}, {:type=>:sequential, :content=>(ring {:type=>:note, :content=>[{:note=>50.0}], :release=>2.0, :mods=>[]}, {:type=>:silence, :mods=>[], :release=>1})}], :index=>0, :release=>1.0, :mods=>[]})}
plan = []
plan_data_structure anvil, 0.0, plan
assert valid_forge_plan? plan
assert_equal plan, [{:time=>0.0, :actions=>[{:type=>:note, :content=>[{:note=>45.0}], :release=>3.0, :mods=>[]}, {:type=>:note, :content=>[{:note=>50.0}], :release=>2.0, :mods=>[]}]}]

anvil = parser.parse("[45, 50]").content
assert valid_anvil? anvil
assert_equal anvil, {:type=>:sequential, :content=>(ring {:type=>:parallel, :content=>[{:type=>:sequential, :content=>(ring {:type=>:note, :content=>[{:note=>45.0}], :release=>1.0, :mods=>[]})}, {:type=>:sequential, :content=>(ring {:type=>:note, :content=>[{:note=>50.0}], :release=>1.0, :mods=>[]})}], :release=>1.0, :mods=>[]})}
apply_mods anvil, false
assert valid_anvil? anvil
assert_equal anvil, {:type=>:sequential, :content=>(ring {:type=>:parallel, :content=>[{:type=>:sequential, :content=>(ring {:type=>:note, :content=>[{:note=>45.0}], :release=>1.0, :mods=>[]})}, {:type=>:sequential, :content=>(ring {:type=>:note, :content=>[{:note=>50.0}], :release=>1.0, :mods=>[]})}], :release=>1.0, :mods=>[]})}
plan = []
plan_data_structure anvil, 0.0, plan
assert valid_forge_plan? plan
assert_equal plan, [{:time=>0.0, :actions=>[{:type=>:note, :content=>[{:note=>45.0}], :release=>1.0, :mods=>[]}, {:type=>:note, :content=>[{:note=>50.0}], :release=>1.0, :mods=>[]}]}]

anvil = parser.parse("[45*2]*2").content
assert valid_anvil? anvil
assert_equal anvil, {:type=>:sequential, :content=>(ring {:type=>:parallel, :content=>[{:type=>:sequential, :content=>(ring {:type=>:note, :content=>[{:note=>45.0}], :release=>1.0, :mods=>[{:type=>:mult, :content=>2}]})}], :release=>1.0, :mods=>[{:type=>:mult, :content=>2}]})}
apply_mods anvil, false
assert valid_anvil? anvil
assert_equal anvil, {:type=>:sequential, :content=>(ring {:type=>:parallel, :content=>[{:type=>:sequential, :content=>(ring {:type=>:note, :content=>[{:note=>45.0}], :release=>1.0, :mods=>[]}, {:type=>:note, :content=>[{:note=>45.0}], :release=>1.0, :mods=>[]})}], :release=>1.0, :mods=>[]}, {:type=>:parallel, :content=>[{:type=>:sequential, :content=>(ring {:type=>:note, :content=>[{:note=>45.0}], :release=>1.0, :mods=>[]}, {:type=>:note, :content=>[{:note=>45.0}], :release=>1.0, :mods=>[]})}], :release=>1.0, :mods=>[]})}
plan = []
plan_data_structure anvil, 0.0, plan
assert valid_forge_plan? plan
assert_equal plan, [{:time=>0.0, :actions=>[{:type=>:note, :content=>[{:note=>45.0}], :release=>0.25, :mods=>[]}]}, {:time=>0.25, :actions=>[{:type=>:note, :content=>[{:note=>45.0}], :release=>0.25, :mods=>[]}]}, {:time=>0.5, :actions=>[{:type=>:note, :content=>[{:note=>45.0}], :release=>0.25, :mods=>[]}]}, {:time=>0.75, :actions=>[{:type=>:note, :content=>[{:note=>45.0}], :release=>0.25, :mods=>[]}]}]

anvil = parser.parse("{45*2}*2").content
assert valid_anvil? anvil
assert_equal anvil, {:type=>:sequential, :content=>(ring {:type=>:timed_parallel, :content=>[{:type=>:sequential, :content=>(ring {:type=>:note, :content=>[{:note=>45.0}], :release=>1.0, :mods=>[{:type=>:mult, :content=>2}]})}], :index=>0, :release=>1.0, :mods=>[{:type=>:mult, :content=>2}]})}
apply_mods anvil, false
assert valid_anvil? anvil
assert_equal anvil, {:type=>:sequential, :content=>(ring {:type=>:timed_parallel, :content=>[{:type=>:sequential, :content=>(ring {:type=>:note, :content=>[{:note=>45.0}], :release=>1.0, :mods=>[]}, {:type=>:note, :content=>[{:note=>45.0}], :release=>1.0, :mods=>[]})}], :index=>0, :release=>1.0, :mods=>[]}, {:type=>:timed_parallel, :content=>[{:type=>:sequential, :content=>(ring {:type=>:note, :content=>[{:note=>45.0}], :release=>1.0, :mods=>[]}, {:type=>:note, :content=>[{:note=>45.0}], :release=>1.0, :mods=>[]})}], :index=>0, :release=>1.0, :mods=>[]})}
plan = []
plan_data_structure anvil, 0.0, plan
assert valid_forge_plan? plan
assert_equal plan, [{:time=>0.0, :actions=>[{:type=>:note, :content=>[{:note=>45.0}], :release=>0.25, :mods=>[]}]}, {:time=>0.25, :actions=>[{:type=>:note, :content=>[{:note=>45.0}], :release=>0.25, :mods=>[]}]}, {:time=>0.5, :actions=>[{:type=>:note, :content=>[{:note=>45.0}], :release=>0.25, :mods=>[]}]}, {:time=>0.75, :actions=>[{:type=>:note, :content=>[{:note=>45.0}], :release=>0.25, :mods=>[]}]}]

anvil = parser.parse("45-2 ~").content
assert valid_anvil? anvil
assert_equal anvil, {:type=>:sequential, :content=>(ring {:type=>:note, :content=>[{:note=>45.0}], :release=>1.0, :mods=>[{:type=>:release, :content=>2.0}]}, {:type=>:silence, :release=>1.0, :mods=>[]})}
apply_mods anvil, false
assert valid_anvil? anvil
assert_equal anvil, {:type=>:sequential, :content=>(ring {:type=>:note, :content=>[{:note=>45.0}], :release=>2.0, :mods=>[]}, {:type=>:silence, :release=>1.0, :mods=>[]})}
plan = []
plan_data_structure anvil, 0.0, plan
assert valid_forge_plan? plan
assert_equal plan, [{:time=>0.0, :actions=>[{:type=>:note, :content=>[{:note=>45.0}], :release=>1.0, :mods=>[]}]}]

anvil = parser.parse("45>50").content
assert valid_anvil? anvil
assert_equal anvil, {:type=>:sequential, :content=>(ring {:type=>:note, :content=>[{:note=>45.0}, {:note=>50.0, :slide=>1}], :release=>1.0, :mods=>[]})}
apply_mods anvil, false
assert valid_anvil? anvil
assert_equal anvil, {:type=>:sequential, :content=>(ring {:type=>:note, :content=>[{:note=>45.0}, {:note=>50.0, :slide=>1}], :release=>1.0, :mods=>[]})}
plan = []
plan_data_structure anvil, 0.0, plan
assert valid_forge_plan? plan
assert_equal plan, [{:time=>0.0, :actions=>[{:type=>:note, :content=>[{:note=>45.0}, {:note=>50.0, :slide=>1}], :release=>1.0, :mods=>[]}]}]

anvil = parser.parse("45^50").content
assert valid_anvil? anvil
assert_equal anvil, {:type=>:sequential, :content=>(ring {:type=>:note, :content=>[{:note=>45.0}, {:note=>50.0, :slide=>0}], :release=>1.0, :mods=>[]})}
apply_mods anvil, false
assert valid_anvil? anvil
assert_equal anvil, {:type=>:sequential, :content=>(ring {:type=>:note, :content=>[{:note=>45.0}, {:note=>50.0, :slide=>0}], :release=>1.0, :mods=>[]})}
plan = []
plan_data_structure anvil, 0.0, plan
assert valid_forge_plan? plan
assert_equal plan, [{:time=>0.0, :actions=>[{:type=>:note, :content=>[{:note=>45.0}, {:note=>50.0, :slide=>0}], :release=>1.0, :mods=>[]}]}]

anvil = parser.parse("45>50^45").content
assert valid_anvil? anvil
assert_equal anvil, {:type=>:sequential, :content=>(ring {:type=>:note, :content=>[{:note=>45.0}, {:note=>50.0, :slide=>1}, {:note=>45.0, :slide=>0}], :release=>1.0, :mods=>[]})}
apply_mods anvil, false
assert valid_anvil? anvil
assert_equal anvil, {:type=>:sequential, :content=>(ring {:type=>:note, :content=>[{:note=>45.0}, {:note=>50.0, :slide=>1}, {:note=>45.0, :slide=>0}], :release=>1.0, :mods=>[]})}
plan = []
plan_data_structure anvil, 0.0, plan
assert valid_forge_plan? plan
assert_equal plan, [{:time=>0.0, :actions=>[{:type=>:note, :content=>[{:note=>45.0}, {:note=>50.0, :slide=>1}, {:note=>45.0, :slide=>0}], :release=>1.0, :mods=>[]}]}]

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