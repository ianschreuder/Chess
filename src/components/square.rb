#
# Squares go from 0->7, 0->7
#
class Square
  attr_reader :x, :y
  
  def initialize(x, y); @x, @y = x, y; end
  def ==(other); return (@x==other.x && @y==other.y); end
  def straight?(other); return false if (self==other); return @x==other.x || @y==other.y; end
  def diagonal?(other); return false if (self==other); return (@x-other.x).abs == (@y-other.y).abs; end
  def to_s; "#{@x+1},#{y+1}"; end

end

