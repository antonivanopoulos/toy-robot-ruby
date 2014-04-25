class Robot

  ORIENTATIONS = [:north, :south, :east, :west]
  LEFT_MOVEMENTS = { north: :west, west: :south, south: :east, east: :north}
  RIGHT_MOVEMENTS = { north: :east, east: :south, south: :west, west: :north}

  attr_accessor :position, :orientation

  def place(x, y)
    if valid_position?(x, y)
      self.position = { x: x, y: y }
    end
  end

  def placed?
    self.position != nil
  end

  def face(orientation)
    if ORIENTATIONS.include?(orientation)
      self.orientation = orientation
    else
      nil
    end
  end

  def turn_left
    self.orientation = LEFT_MOVEMENTS[self.orientation]
  end

  def turn_right
    self.orientation = RIGHT_MOVEMENTS[self.orientation]
  end

  def move
    position = self.position
    trajectory = self.trajectory
    message = nil

    begin
      if valid_position?(position[:x] + trajectory[:x], position[:y] + trajectory[:y])
        self.position = { x: position[:x] + trajectory[:x], y: position[:y] + trajectory[:y] }
      else
        message = "Invalid movement."
      end
    rescue
      message = "Invalid movement."
    end

    message
  end

  def trajectory
    case self.orientation
    when :north
      { x: 0, y: 1}
    when :east
      { x: 1, y: 0}
    when :south
      { x: 0, y: -1}
    when :west
      { x: -1, y: 0}
    end
  end

  def report
    "Output: #{self.position[:x]},#{self.position[:y]},#{self.orientation.to_s.upcase}"
  end

  private

    def valid_position?(x, y)
      (x >= 0 && x <= 4 && y >= 0 && y <= 4)
    end

end