# require File.dirname(__FILE__) + '/components/pieces/piece.rb'
# Dir['./components/**/*.rb'].map {|f| require f}

# class Game
#   attr_reader :current_player, :board

#   def initialize(player1 = nil, player2 = nil)
#     @player1 = player1.nil? ? Player.new(WHITE) : player1
#     @player2 = player2.nil? ? Player.new(BLACK) : player2
#     @board = Board.new(@player1, @player2)
#     @current_player = @player1
#   end
  
#   def run
#     while !complete? do
#       move = @current_player.next_move
#       @current_position.update_with_move(move)
#       @current_player = next_player
#     end
#   end

#   def complete?
#     true if @board.moves.length > 10
#   end

#   def draw?
#     return true if stalemate?
#   end
  
#   def stalemate?
#     return true
#   end
  
#   private
  
#   def next_player
#     @current_player = (@current_player == @player1) ? @player2 : @player1
#     @current_player
#   end

# end

# # require 'perftools'
# # PerfTools::CpuProfiler.start("../../chess_profile") do
#   # Game.new.run
# # end
# # a = Time.now
# # # 30.times {Game.new.run}
# # threads = []
# # 30.times { threads << Thread.new {Game.new.run} }
# # threads.each{|t| t.join}
# # p "Took: #{(Time.now - a)} secs"
# # p "For a game/sec rate of: #{30 / (Time.now-a).to_f}"
