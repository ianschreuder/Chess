# require File.dirname(__FILE__) + '/pieces/piece.rb'
# Dir[File.dirname(__FILE__) + '/**/*.rb'].each {|file| require file }
# 
# class Game
#   attr_reader :current_position, :current_player
# 
#   def initialize(player1 = Player.new(:white), player2 = Player.new(:black))
#     @player1, @player2 = player1, player2
#     @current_position = Position.new
#     @current_position.new_game_setup
#     @current_player = @player1
#   end
#   
#   def run
#     while !complete? do
#       move = @current_player.next_move(@current_position)
#       @current_position.update_with_move(move)
#       @current_player = next_player
#     end
#   end
# 
#   def complete?
#     true if @current_position.moves.length > 10
#   end
# 
#   def draw?
#     return true if stalemate?
#   end
#   
#   def stalemate?
#     return true
#   end
#   
#   private
#   
#   def next_player
#     @current_player = (@current_player == @player1) ? @player2 : @player1
#     @current_player
#   end
# 
# end
# 
# require 'perftools'
# PerfTools::CpuProfiler.start("../../chess_profile") do
#   Game.new.run
# end
# # a = Time.now
# # # 30.times {Game.new.run}
# # threads = []
# # 30.times { threads << Thread.new {Game.new.run} }
# # threads.each{|t| t.join}
# # p "Took: #{(Time.now - a)} secs"
# # p "For a game/sec rate of: #{30 / (Time.now-a).to_f}"
