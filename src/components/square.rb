#
# Squares go from 0->7, 0->7
# col is verticals (Y) (a,b,c,d,e,f,g,h)
# row is horizontal (X) (1,2,3,4,5,6,7,8)
#
class Square
  attr_reader :x, :y, :board
  
  def initialize(board, x, y)
    @board, @x, @y = board, x, y
  end
  def straight?(other); return false if (self==other); return @x==other.x || @y==other.y; end
  def diagonal?(other); return false if (self==other); return (@x-other.x).abs == (@y-other.y).abs; end
  def to_s; "#{@x},#{y}"; end
  def row; @y; end
  def col; @x; end
  def at?(x,y); return (@x==x && @y==y); end
  def to_sym; "#{('a'..'h').to_a[x]}#{y+1}".to_sym; end


end

