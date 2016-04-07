require 'treetop'
Treetop.load 'PATH_TO/grammar/forge_grammar.tt'

parser = ForgeGrammarParser.new

# Equal Tests

INPUTS = [
  [ "" , " "],
  [ "k" , " k " ],
  [ "k" , "k*1" ],
  [ "k" , "k(1,1)" ],
  [ "k k" , "k*2" ],
  [ "[]" , " [ ] " ]
]

INPUTS.each do |inputs|
  anvil0 = parser.parse(inputs[0]).content
  assert valid_anvil? anvil0
  anvil1 = parser.parse(inputs[1]).content
  assert valid_anvil? anvil1
  apply_mods anvil0, false
  assert valid_anvil? anvil0
  apply_mods anvil1, false
  assert valid_anvil? anvil1
  assert_equal anvil0, anvil1
  plan0 = []
  plan_data_structure anvil0, 0.0, plan0
  assert valid_forge_plan? plan0
  plan1 = []
  plan_data_structure anvil0, 0.0, plan1
  assert valid_forge_plan? plan1
  assert_equal plan0, plan1
  puts '"' + inputs[0] + '" = "' + inputs[1] + '"'
end