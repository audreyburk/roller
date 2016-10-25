require './roller'

ARGV.each do |input|
  input = [input]
  output = Roller.process input
end
