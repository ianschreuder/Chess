class Game
  attr_reader :player1, :player2, :board

  def initialize(player1, player2)
    white = [player1, player2].detect{|pl| pl.side == :white}
    black = (player1==white) ? player2 : player1
    @board = Board.new(white, black)
  end
  
end