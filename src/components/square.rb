class Square
  attr_reader :col, :row
  
  # coords are specified as column,row
  def initialize(coord)
    @col = ((a = coord.to_s.slice(0..0)).to_i == 0) ? to_num(a) : a.to_i
    @row = coord.to_s.slice(1..1).to_i
  end

  def ==(other)
    return false unless other && other.is_a?(Square)
    (self.row == other.row && self.col == other.col)
  end

  def horizontal?(other)
    return false unless other && self.row && other.row && self.col && other.col
    (self.row == other.row || self.col == other.col)
  end
  
  def diagonal?(other)
    return false unless other && self.row && other.row && self.col && other.col
    (self.row - other.row).abs == (self.col - other.col).abs
  end
  
  def to_s
    ":#{to_letter(col)}#{row}"
  end

  def coord_key
    "#{to_letter(col)}#{row}".to_sym
  end

  private

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

