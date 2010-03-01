class Square
  attr_reader :row, :col
  
  def initialize(coord)
    @col = ((a = coord.to_s.slice(0..0)).to_i == 0) ? to_num(a) : a.to_i
    @row = coord.to_s.slice(1..1).to_i
  end

  def self.squares
    cols = %w(1 2 3 4 5 6 7 8) # these would be a, b, ... but easier with numbers
    rows = %w(1 2 3 4 5 6 7 8)
    all = []
    cols.each{|col| rows.each{|row| all << Square.new("#{col}#{row}".to_sym)}}
    return all
  end

  def diagonals
    Square.squares.select{|square| self.diagonal?(square)}.reject{|square| square == self} 
  end

  def horizontals
    Square.squares.select{|square| self.horizontal?(square)}.reject{|square| square == self} 
  end

  def knight_squares
    Square.squares.select{|square| ((square.row - self.row).abs == 1 && (square.col - self.col).abs == 2) || ((square.row - self.row).abs == 2 && (square.col - self.col).abs == 1) }
  end

  def horizontal?(other)
    return false unless other && self.row && other.row && self.col && other.col
    (self.row == other.row || self.col == other.col)
  end
  
  def diagonal?(other)
    return false unless other && self.row && other.row && self.col && other.col
    (self.row - other.row).abs == (self.col - other.col).abs
  end
  
  def squares_between(other)
    raise ArgumentError, "Invalid squares for path evaluation" unless self.horizontal?(other) || self.diagonal?(other)
    if self.horizontal?(other)
      return horizontal_between(other)
    else
    end
  end

  def ==(other)
    return false unless other && other.is_a?(Square)
    (self.row == other.row && self.col == other.col)
  end
  
  def to_s
    ":#{to_letter(col)}#{row}"
  end
  
  private
  
  def horizontal_between(other)
    return [] unless (self.row - other.row).abs > 1 || (self.col - other.col).abs > 1
    return rows_between(other) if self.row == other.row
  end
  
  def to_letter(num)
    case num
    when 1 then "a"
    when 2 then "b"
    when 3 then "c"
    when 4 then "d"
    when 5 then "e"
    when 6 then "f"
    when 7 then "g"
    when 8 then "h"
    end
  end
  def to_num(letter)
    case letter
    when "a" then 1
    when "b" then 2
    when "c" then 3
    when "d" then 4
    when "e" then 5
    when "f" then 6
    when "g" then 7
    when "h" then 8
    end
  end
    

end

