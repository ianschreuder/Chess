require File.dirname(__FILE__) + '/pieces/piece.rb'
Dir[File.dirname(__FILE__) + '/**/*.rb'].each {|file| require file }

class Game
  attr_reader :current_position, :current_player

  def initialize(player1, player2)
    @player1, @player2 = player1, player2
    white = [player1, player2].detect{|pl| pl.side == :white}
    black = (player1==white) ? player2 : player1
    @current_position = Position.new
    @current_position.new_game_setup
    @current_player = @player1
  end
  
  def run
  end

  def complete?
    false
  end

  def draw?
    return true if position.stalemate?
  end

end