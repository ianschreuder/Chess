class Player
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def move(position)
    valid_pieces = position.pieces(@color).reject{|piece| piece.legal_moves(position).empty? }
    piece = valid_pieces[rand(valid_pieces.length)]
    piece.legal_moves(position)[rand(piece.legal_moves(position).length)] if piece
  end

  private

end