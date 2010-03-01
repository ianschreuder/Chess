require File.dirname(__FILE__) + '/pieces/piece.rb'
Dir[File.dirname(__FILE__) + '/**/*.rb'].each {|file| require file }

class Game
  attr_reader :board

  def initialize(player1, player2)
    @player1, @player2 = player1, player2
    white = [player1, player2].detect{|pl| pl.side == :white}
    black = (player1==white) ? player2 : player1
    @board = Board.new(white, black)
    @current_player = @player1
  end
  
  def run
    move = @current_player.move(self, @last_move)
  end

  def position
    Position.new(@board.pieces)
  end
  
  def current
    @current_player
  end
  
  def complete?
    false
  end

  def stalemate?
    false
  end

end