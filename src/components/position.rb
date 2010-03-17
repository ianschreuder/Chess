class Position
  
  
  def initialize(all_pieces)
    @white_pieces = all_pieces.select{|pi| pi.color == :white}
    @black_pieces = all_pieces.select{|pi| pi.color == :black}
  end

  def blocked?(source, target)
    squares = source.path(target)
    squares.detect{|sq| pieces.detect{|p| p.square == sq}} != nil
  end
  
  def occupier(square)
    pieces.detect{|piece| piece.square == square}
  end
  
  private
  
  def pieces
    @white_pieces + @black_pieces
  end
  
end