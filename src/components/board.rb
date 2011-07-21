class Board
  attr_accessor :squares
  
  def initialize
    @squares = (0..7).inject([]){|arr, i| (0..7).each{|j| arr << Square.new(i,j)}; arr}
  end
  def square_at(x,y); return @squares.detect{|s| s.x==x && s.y==y}; end
  def diagonals(sqr); @squares.select{|s| s.diagonal?(sqr)}; end
  def straights(sqr); @squares.select{|s| s.straight?(sqr)}; end
  def knight_squares(sqr); @squares.select{|s| ((s.x - sqr.x).abs == 1 && (s.y - sqr.y).abs == 2) || ((s.x - sqr.x).abs == 2 && (s.y - sqr.y).abs == 1) }; end
  def path(s1, s2)
    return [] if ((s1.x != s2.x && s1.y != s2.y) && (s1.x-s2.x).abs != (s1.y-s2.y).abs)
    return straight_path(s1,s2) if (s1.x == s2.x || s1.y == s2.y)
    return diagonal_path(s1,s2) if (s1.x - s2.x).abs == (s1.y - s2.y).abs
  end
  def straight_path(s1, s2)
    return false unless s1.x == s2.x || s1.y == s2.y
    return @squares.select{|s| s.x == s1.x && s.y < [s1.y,s2.y].max && s.y > [s1.y,s2.y].min} if (s1.x == s2.x)
    return @squares.select{|s| s.y == s1.y && s.x < [s1.x,s2.x].max && s.x > [s1.x,s2.x].min} if (s1.y == s2.y)
  end
  def diagonal_path(s1, s2)
    return false unless (s1.x - s2.x).abs == (s1.y - s2.y).abs
    return @squares.select{|s| s.x < [s1.x,s2.x].max && s.x > [s1.x,s2.x].min && 
                                     s.y < [s1.y,s2.y].max && s.y > [s1.y,s2.y].min &&
                                     (s1.x - s.x).abs == (s1.y - s.y).abs}
  end


end
