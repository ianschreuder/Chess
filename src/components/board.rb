class Board

  def self.diagonals(square)
    Board.squares.select{|other| square.diagonal?(other)}.reject{|other| other == square} 
  end

  def self.horizontals(square)
    Board.squares.select{|other| square.horizontal?(other)}.reject{|other| other == square} 
  end

  def self.knight_squares(square)
    Board.squares.select{|other| ((other.row - square.row).abs == 1 && (other.col - square.col).abs == 2) || ((other.row - square.row).abs == 2 && (other.col - square.col).abs == 1) }
  end

  # returns the squares along the path between two points, either diagonal or horizontal
  def self.path(square1, square2)
    return [] if ((square1.row != square2.row && square1.col != square2.col) && (square1.row-square2.row).abs != (square1.col-square2.col).abs)
    return straight_path(square1,square2) if (square1.row == square2.row || square1.col == square2.col)
    return diagonal_path(square1,square2) if (square1.row - square2.row).abs == (square1.col - square2.col).abs
  end
  
  def self.squares
    @@squares ||= self.create_all_squares
  end
  
  def self.square_at(coord_key)
    Board.squares.detect{|s| s.coord_key == coord_key}
  end
  
  private
  
  def self.create_all_squares
    cols = %w(1 2 3 4 5 6 7 8) # these would be a, b, ... but easier with numbers
    rows = %w(1 2 3 4 5 6 7 8)
    all = []
    cols.each{|col| rows.each{|row| all << Square.new("#{col}#{row}".to_sym)}}
    return all
  end

  def self.straight_path(square1, square2)
    return false unless square1.row == square2.row || square1.col == square2.col
    return Board.squares.select{|s| s.row == square1.row && s.col < [square1.col,square2.col].max && s.col > [square1.col,square2.col].min} if (square1.row == square2.row)
    return Board.squares.select{|s| s.col == square1.col && s.row < [square1.row,square2.row].max && s.row > [square1.row,square2.row].min} if (square1.col == square2.col)
  end
  
  def self.diagonal_path(square1,square2)
    return false unless (square1.row - square2.row).abs == (square1.col - square2.col).abs
    return Board.squares.select{|s| s.row < [square1.row,square2.row].max && s.row > [square1.row,square2.row].min && 
                                     s.col < [square1.col,square2.col].max && s.col > [square1.col,square2.col].min &&
                                     (square1.row - s.row).abs == (square1.col - s.col).abs}
  end
  
end