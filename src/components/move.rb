class Move
  attr_reader :piece, :piece_start, :piece_end, :target_piece, :ancillary_piece, :ancillary_piece_start, :ancillary_piece_end
  
  def initialize(position, piece, target_square)
    @piece = piece
    @piece_start = piece.square
    @piece_end = target_square
    determine_target(position)
    determine_ancillary(position)
  end
  
  def execute
    @piece.set_square(@piece_end)
    @target_piece.set_square(nil) if @target_piece
  end
  
  def reset
    @piece.set_square(@piece_start)
    @target_piece.set_square(@target_square) if @target_piece
  end
  
  def creates_en_passant?
    return (@piece.class == Pawn && (@piece_start.col - @piece_end.col).abs == 2 && (@piece_start.row - @piece_end.row).abs == 0)
  end
  
  def en_passant_square
    Board.path(@piece_start, @piece_end)[0] if creates_en_passant?
  end
    
  private
  
  def determine_target(position)
    if @piece.class != Pawn || (position.last_move && !position.last_move.creates_en_passant?)
      @target_piece = position.occupier(@piece_end)
      @target_square = @target_piece.square unless @target_piece.nil?
    elsif (@piece.class == Pawn && position.last_move && position.last_move.creates_en_passant? && @piece_end == position.last_move.en_passant_square)
      @target_piece = position.last_move.piece
      @target_square = @target_piece.square
    end
  end
  
  def determine_ancillary(position)
    
  end
  
end