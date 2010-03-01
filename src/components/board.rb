class Board

  def initialize(white, black)
    @player_white = white
    @player_black = black
    initialize_pieces
  end
  
  def black_pieces() @player_black.pieces; end
  def white_pieces() @player_white.pieces; end
  def pieces() black_pieces + white_pieces; end

  private
  
  def initialize_pieces
    white_pieces = []
    black_pieces = []
    %w(a b c d e f g h).each{|ltr| white_pieces << Pawn.new(ltr+"2".to_sym); black_pieces << Pawn.new(ltr+"7".to_sym) }
    %w(a h).each{|ltr| white_pieces << Rook.new(ltr+"1".to_sym); black_pieces << Rook.new(ltr+"8".to_sym) }
    %w(b g).each{|ltr| white_pieces << Knight.new(ltr+"1".to_sym); black_pieces << Knight.new(ltr+"8".to_sym) }
    %w(c f).each{|ltr| white_pieces << Bishop.new(ltr+"1".to_sym); black_pieces << Bishop.new(ltr+"8".to_sym) }
    white_pieces << Queen.new(:d1)
    black_pieces << Queen.new(:d8)
    white_pieces << King.new(:e1)
    black_pieces << King.new(:e8)
    @player_white.pieces = white_pieces
    @player_black.pieces = black_pieces
  end

  
  
end