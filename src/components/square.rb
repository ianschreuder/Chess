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
  
  def ==(other)
    return false unless other && other.is_a?(Square)
    (self.row == other.row && self.col == other.col)
  end
  
  # returns the squares along the path between two points, either diagonal or horizontal
  def path(other)
    return [] if ((row != other.row && col != other.col) && (row-other.row).abs != (col-other.col).abs)
    return straight_path(other) if (row == other.row || col == other.col)
    return diagonal_path(other) if (row - other.row).abs == (col - other.col).abs
  end
  
  def to_s
    ":#{to_letter(col)}#{row}"
  end
  
  private

  def straight_path(other)
    return false unless row == other.row || col == other.col
    return Square.squares.select{|s| s.row == row && s.col < [col,other.col].max && s.col > [col,other.col].min} if (row == other.row)
    return Square.squares.select{|s| s.col == col && s.row < [row,other.row].max && s.row > [row,other.row].min} if (col == other.col)
  end
  
  def diagonal_path(other)
    return false unless (row - other.row).abs == (col - other.col).abs
    return Square.squares.select{|s| s.row < [row,other.row].max && s.row > [row,other.row].min && 
                                     s.col < [col,other.col].max && s.col > [col,other.col].min &&
                                     (row - s.row).abs == (col - s.col).abs}
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

