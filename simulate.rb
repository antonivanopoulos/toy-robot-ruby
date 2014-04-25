require_relative 'lib/simulator'

simulator = Simulator.new
puts "Welcome to the toy robot simulator, enter a PLACE command to begin:"

command = STDIN.gets
while command
  output = simulator.execute(command)
  puts output if output
  command = STDIN.gets
end