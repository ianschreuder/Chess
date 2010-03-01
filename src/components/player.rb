class Player
  attr_reader :side
  attr_accessor :pieces

  def initialize(side)
    @side = side
  end

  def move(position, last_move = nil)
    valid_pieces = @pieces.select{|p| p.legal_moves(position, last_move).length > 0}
    piece = valid_pieces[rand(valid_pieces.length)]
    piece.legal_moves(position, last_move)[rand(piece.legal_moves(position, last_move).length)] if piece
  end

  private

end