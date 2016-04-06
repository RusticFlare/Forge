require 'treetop'
Treetop.load 'PATH_TO/grammar/forge_grammar.tt'

parser = ForgeGrammarParser.new

# Time Analysis Tests

max_parse_time = nil
min_parse_time = nil
avg_parse_time = 0
max_apply_mods_time = nil
min_apply_mods_time = nil
avg_apply_mods_time = 0
max_generate_time = nil
min_generate_time = nil
avg_generate_time = 0

TIMES = 1024

TIMES.times do
  time0 = Time.now
  anvil = parser.parse("[{56(5,6) 50^60}, k ~ k]/7 [50>60]*4 [k [[~ 57 46*7 ~ ~], k] cc co]").content
  time1 = Time.now
  apply_mods anvil, false
  time2 = Time.now
  parse_time = time1 - time0
  apply_mods_time = time2 - time1
  generate_time = time2 - time0
  if max_parse_time == nil || max_parse_time < parse_time
    max_parse_time = parse_time
  end
  if min_parse_time == nil || min_parse_time > parse_time
    min_parse_time = parse_time
  end
  if max_apply_mods_time == nil || max_apply_mods_time < apply_mods_time
    max_apply_mods_time = apply_mods_time
  end
  if min_apply_mods_time == nil || min_apply_mods_time > apply_mods_time
    min_apply_mods_time = apply_mods_time
  end
  if max_generate_time == nil || max_generate_time < generate_time
    max_generate_time = generate_time
  end
  if min_generate_time == nil || min_generate_time > generate_time
    min_generate_time = generate_time
  end
  avg_parse_time = avg_parse_time + parse_time
  avg_apply_mods_time = avg_apply_mods_time + apply_mods_time
  avg_generate_time = avg_generate_time + apply_mods_time
end

puts "min_parse_time = " + min_parse_time.to_s
puts "max_parse_time = " + max_parse_time.to_s
puts "avg_parse_time = " + (avg_parse_time / TIMES).to_s
puts "min_apply_mods_time = " + min_apply_mods_time.to_s
puts "max_apply_mods_time = " + max_apply_mods_time.to_s
puts "avg_apply_mods_time = " + (avg_apply_mods_time / TIMES).to_s
puts "min_generate_time = " + min_generate_time.to_s
puts "max_generate_time = " + max_generate_time.to_s
puts "avg_generate_time = " + (avg_generate_time / TIMES).to_s