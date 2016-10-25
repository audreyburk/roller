require 'byebug'
require './dice'

class Roller

  OPERATORS = %w( + - * / h l )

  def initialize
  end
  # exploding could be a recursive call that gets added to the basic output?

  def self.parse(commands)
    commands.map do |command|
      needs_parsing  = false
      operator       = nil
      operator_count = 0

      OPERATORS.each do |op|
        operator_count = command.count op
        if operator_count > 0
          needs_parsing  = true
          operator       = op
          break
        end
      end

      if needs_parsing
        new_command = command.split(operator)
        new_command = parse new_command
        operator_count.times { new_command << operator }
        new_command
      else
        if command.include? "d"
          Dice.new(command)
        elsif OPERATORS.include? command
          command
        else
          command.to_i
        end
      end
    end
  end

  def self.calculate(commands)
    while commands.any? { |c| c.is_a?(Array) || c.is_a?(Dice) }
      commands.map! do |command|
        if command.is_a? Array
          calculate command
        elsif command.is_a? Dice
          command.value
        else
          command
        end
      end
    end

    until commands.length == 1
      p commands
      operator = commands.pop
      number   = commands.shift
      commands[0] = number.send(operator, commands.first)
    end
    commands.first
  end

  def self.display(output)
    puts output
  end

  def self.process(input)
    commands = parse input
    result   = calculate commands
    display result
  end
end
