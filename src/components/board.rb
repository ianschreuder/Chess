class Board

  def initialize(white, black)
    @player_white = white
    @player_black = black
  end

  def pieces
    @player_white.pieces + @player_black.pieces
  end

end