require_relative 'robot'

class Simulator

  def initialize
    @robot = Robot.new
  end

  def execute(command)
    return if command.strip.empty?

    tokens = command.split(/\s+/)
    operator = tokens.first
    arguments = tokens.last

    case operator
    when 'PLACE'
      place(arguments)
    when 'REPORT'
      report
    when 'MOVE'
      move
    when 'LEFT'
      left
    when 'RIGHT'
      right
    when 'EXIT'
      puts "Goodbye."
      exit
    else
      "Ignoring invalid command #{operator}."
    end
  end

  private

  def left
    return 'Ignoring LEFT command until robot is PLACED.' unless @robot.placed?
    @robot.turn_left
    nil
  end

  def right
    return 'Ignoring RIGHT command until robot is PLACED.' unless @robot.placed?
    @robot.turn_right
    nil
  end

  def move
    return 'Ignoring MOVE command until robot is PLACED.' unless @robot.placed?
    @robot.move
  end

  def place(position)
    message = nil

    begin
      tokens = position.split(/,/)
      x = tokens[0].to_i
      y = tokens[1].to_i
      orientation = tokens[2].downcase.to_sym

      unless @robot.face(orientation) && @robot.place(x, y)
        message = "Ignoring PLACE command containing invalid arguments."
      end
    rescue
      message = "Ignoring PLACE command containing invalid arguments."
    end

    message
  end

  def report
    return 'Ignoring REPORT command until robot is PLACED.' unless @robot.placed?
    @robot.report
  end
end