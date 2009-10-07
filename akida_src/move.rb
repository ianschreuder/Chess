=begin
  Move generates a set of moves from a given position 
=end

require 'bitboard'

class Move
  
  attr_reader :position

  # Create a new Move for a specific position
  # raise an ArgumentError if the initial value is not a Position object
  def initialize(position)
    raise ArgumentError, "You must provide a Position object - #{position} is type #{position.class}" if position.class != Position  
    @position = position
  end

    # generate the moves that the knights can make from their current positions
    # for a given side (:black or :white)
  def gen_knight_moves(side)
    moves = []
    
    # knights can't move to squares occupied by their own side
    # so determine where the knights comrades are
    if side == :white
      position = @position.white  
      comrades = @position.white_pieces
    else
      position = @position.black
      comrades = @position.black_pieces
    end
    
    # no work to do when there are no knights
    return moves if position[:knight].nil?
    
    # for each knight 
    position[:knight].set_bits.each do |from| 
      # valid moves are all those squares attacked from the current
      # position that aren't occupied by comrades
      move_to = Move::Attacks[:knight][from] & ~comrades
      move_to.set_bits.each do |to|      
        moves.push [Squares.index(from), Squares.index(to)]
      end
    end
    moves
  end
  
  # generate the moves that the pawns can make from their current positions
  # NB no en-passant or promotion yet. 
  def gen_pawn_moves(side)
    moves = []
    all = @position.all_pieces
    
    if side == :white
      position = @position.white  
      enemy    = @position.black_pieces
      #white pawn moves up the board (increasing bit index order)
      delta    = 8
    else
      position = @position.black
      enemy    = @position.white_pieces
      #white pawn moves down the board (decreasing bit index order)
      delta    = -8
    end
    # no work to do when there are no pawns 
    return moves if position[:pawn].nil?
    
    # for each pawn
    position[:pawn].set_bits.each do |from| 
      # valid moves are those moves to a free square...
      to = from + delta
      if all.clear?(to) 
        moves << [Squares.index(from), Squares.index(to)]
        to += delta
        moves << [Squares.index(from), Squares.index(to)] if not_moved_yet(side, from) && all.clear?(to)
      end
      
      # ...plus attacks on the enemies pieces
      move_to = (Move::Attacks[:pawn][side][from] & enemy)
      move_to.set_bits.each { |to| moves << [Squares.index(from), Squares.index(to)] }
    end
    moves
  end
  
  def not_moved_yet(side, square)
    (side == :white && square < 16) ||
    (side == :black && square > 47) 
  end
  
  # generate the moves that the rooks can make from their current positions
  # the piece parameter is there to allow the queen to use this method to 
  # generate her moves
  def gen_rook_moves(side, piece=:rook)
    moves = []
    if side == :white
      position = @position.white  
      comrades = @position.white_pieces
      enemy = @position.black_pieces
    else
      position = @position.black
      comrades = @position.black_pieces
      enemy = @position.white_pieces
    end

    # no work to do when there are no pieces
    return moves if position[piece].nil?
    
    # for each piece
    position[piece].set_bits.each do |from| 
      # [i,j] = current position
      i = from / 8
      j = from % 8

      #dirs flags which directions the piece is blocked
      dirs = 0
      for k in 1..7
        break if dirs == 0xf
        
        # try moving north
        if (dirs & 0x1) != 0x1
          to = from+k*8
          if i+k>7 || comrades.set?(to)
            # no further north moves possible
            dirs = dirs | 0x1
          else
            moves.push [Squares.index(from), Squares.index(to)]
            # if it's occupied by the enemy, no further north moves possible
            dirs = dirs | 0x1 if enemy.set?(to) 
          end
        end
        
        # try moving south
        if (dirs & 0x2) != 0x2
          to = from-k*8
          if i<k || comrades.set?(to)
            # no further south moves possible
            dirs = dirs | 0x2
          else
            moves.push [Squares.index(from), Squares.index(to)]
            # if it's occupied by the enemy, no further north moves possible
            dirs = dirs | 0x2 if enemy.set?(to) 
          end
        end
        
        # try moving east
        if (dirs & 0x4) != 0x4
          to = from+k
          if j+k>7 || comrades.set?(to)
            # no further east moves possible
            dirs = dirs | 0x4
          else
            moves.push [Squares.index(from), Squares.index(to)]
            # if it's occupied by the enemy, no further east moves possible
            dirs = dirs | 0x4 if enemy.set?(to) 
          end
        end
                
        # try moving west
        if (dirs & 0x8) != 0x8
          to = from-k
          if j-k<0 || comrades.set?(to)
            # no further east moves possible
            dirs = dirs | 0x8
          else
            moves.push [Squares.index(from), Squares.index(to)]
            # if it's occupied by the enemy, no further west moves possible
            dirs = dirs | 0x8 if enemy.set?(to) 
          end
        end        
      end
    end  
    moves
  end
  

  # generate the moves that the bishops can make from their current positions
  # the piece parameter is there to allow the queen to use this method to 
  # generate her moves
  def gen_bishop_moves(side, piece=:bishop)
    moves = []
    if side == :white
      position = @position.white  
      comrades = @position.white_pieces
      enemy = @position.black_pieces
    else
      position = @position.black
      comrades = @position.black_pieces
      enemy = @position.white_pieces
    end

    # no work to do when there are no pieces
    return moves if position[piece].nil?
    
    # for each piece
    position[piece].set_bits.each do |from| 
      # [i,j] = current position
      i = from / 8
      j = from % 8

      #dirs flags which directions the piece is blocked
      dirs = 0
      for k in 1..7
        break if dirs == 0xf
        
        # try moving north-east
        if (dirs & 0x1) != 0x1
          to = from+k*9
          if i+k>7 || j+k>7 || comrades.set?(to)
            # no further north-east moves possible
            dirs = dirs | 0x1
          else
            moves.push [Squares.index(from), Squares.index(to)]
            # if it's occupied by the enemy, no further north moves possible
            dirs = dirs | 0x1 if enemy.set?(to) 
          end
        end
        
        # try moving south-west
        if (dirs & 0x2) != 0x2
          to = from-k*9
          if i<k || j<k || comrades.set?(to)
            # no further south-west moves possible
            dirs = dirs | 0x2
          else
            moves.push [Squares.index(from), Squares.index(to)]
            # if it's occupied by the enemy, no further south-west moves possible
            dirs = dirs | 0x2 if enemy.set?(to) 
          end
        end
                
        # try moving north-west
        if (dirs & 0x4) != 0x4
          to = from+k*7
          if i+k>7 || j<k || comrades.set?(to)
            # no further north-west moves possible
            dirs = dirs | 0x4
          else
            moves.push [Squares.index(from), Squares.index(to)]
            # if it's occupied by the enemy, no further north-west moves possible
            dirs = dirs | 0x4 if enemy.set?(to) 
          end
        end  
              
        # try moving south-east
        if (dirs & 0x8) != 0x8
          to = from-k*7
          if i<k || j+k>7 || comrades.set?(to)
            # no further south-east moves possible
            dirs = dirs | 0x8
          else
            moves.push [Squares.index(from), Squares.index(to)]
            # if it's occupied by the enemy, no further south-east moves possible
            dirs = dirs | 0x8 if enemy.set?(to) 
          end
        end
                
      end
    end  
    moves
  end
  
  # generate the moves that the king can make from his current positions
  # without regard for being in check, or castling (yet)
  def gen_king_moves(side)
    moves = []
    if side == :white
      position = @position.white  
      comrades = @position.white_pieces
    else
      position = @position.black
      comrades = @position.black_pieces
    end
    
    # there is only one king, but keep the structure for consistency
    position[:king].set_bits.each do |from| 
      # valid moves are those moves not blocked by our own pieces
      move_to = (Move::Attacks[:king][from] & ~comrades) 
      move_to.set_bits.each { |to| moves.push [Squares.index(from), Squares.index(to)] }
    end
    
    moves
  end
  
  def gen_queen_moves(side)
    gen_rook_moves(side, :queen) + gen_bishop_moves(side, :queen) 
  end
  
  def gen_all_moves(side)
    moves =   gen_pawn_moves    side 
    moves +=  gen_knight_moves  side 
    moves +=  gen_bishop_moves  side 
    moves +=  gen_rook_moves    side 
    moves +=  gen_queen_moves   side 
    moves +=  gen_king_moves    side 
    moves
  end

  # debugging helpers
  def self.print_board(bits, f=nil)
    if f
      f.printf("\n%08b", Move.mirror((bits & (0b11111111<<56))>>56))
      f.printf("\n%08b", Move.mirror((bits & (0b11111111<<48))>>48))
      f.printf("\n%08b", Move.mirror((bits & (0b11111111<<40))>>40))
      f.printf("\n%08b", Move.mirror((bits & (0b11111111<<32))>>32))
      f.printf("\n%08b", Move.mirror((bits & (0b11111111<<24))>>24))
      f.printf("\n%08b", Move.mirror((bits & (0b11111111<<16))>>16))
      f.printf("\n%08b", Move.mirror((bits & (0b11111111<< 8))>> 8))
      f.printf("\n%08b", Move.mirror( bits &  0b11111111))
    else
      printf("\n%08b", Move.mirror((bits & (0b11111111<<56))>>56))
      printf("\n%08b", Move.mirror((bits & (0b11111111<<48))>>48))
      printf("\n%08b", Move.mirror((bits & (0b11111111<<40))>>40))
      printf("\n%08b", Move.mirror((bits & (0b11111111<<32))>>32))
      printf("\n%08b", Move.mirror((bits & (0b11111111<<24))>>24))
      printf("\n%08b", Move.mirror((bits & (0b11111111<<16))>>16))
      printf("\n%08b", Move.mirror((bits & (0b11111111<< 8))>> 8))
      printf("\n%08b", Move.mirror( bits &  0b11111111))
    end
  end

  def self.mirror(bits)
    n=0
    0.upto(7){|i| n|=Bitboard::Mask[7-i] if Bitboard::Mask[i] & bits == Bitboard::Mask[i]}
    n
  end

  # Generate all the attack structures that indicate which 
  # squares can be reached for each type of piece.
  # These are used to get a candidate list of squares when generating moves
  def self.gen_attacks
    @@rook_attacks    = Array.new(64)
    @@bishop_attacks  = Array.new(64)
    @@king_attacks    = Array.new(64)
    @@knight_attacks  = Array.new(64)
    # pawns need separate white and black structures because they move in opposite directions
    @@pawn_attacks    = { :white => Array.new(64), 
                          :black => Array.new(64)}
    # rooks attack along the length of a row; 
    # this array simplifies the generation of the attack structure 
    @@row_attacks = [ 0b11111111    ,   # a1-h1
                      0b11111111<< 8,   # a2-h2
                      0b11111111<<16,   # a3-h3
                      0b11111111<<24,   # a4-h4
                      0b11111111<<32,   # a5-h5
                      0b11111111<<40,   # a6-h6
                      0b11111111<<48,   # a7-h7
                      0b11111111<<56]   # a8-h8
    
    # rooks attack along the length of a row; 
    # this array simplifies the generation of the attack structure 
    @@col_attacks = Array.new(8, 0)
    0.upto(7) { |i| @@col_attacks[i] += Bitboard::Mask[i   ] +  # e.g. a1 
                                        Bitboard::Mask[i+ 8] +  # e.g. a2
                                        Bitboard::Mask[i+16] +  # e.g. a3
                                        Bitboard::Mask[i+24] +  # e.g. a4 
                                        Bitboard::Mask[i+32] +  # e.g. a5 
                                        Bitboard::Mask[i+40] +  # e.g. a6 
                                        Bitboard::Mask[i+48] +  # e.g. a7 
                                        Bitboard::Mask[i+56] }  # e.g. a8 
    # iterate through all board positions [i,j] 
    # generating the appropriate attacks for each square
    for i in 0..7
      for j in 0..7
        Move.gen_rook_attacks(i,j)
        Move.gen_bishop_attacks(i,j)
        # queen = rook | bishop (no need to store)
        Move.gen_knight_attacks(i,j)
        Move.gen_king_attacks(i,j)
        Move.gen_pawn_attacks(i,j)
      end
    end
  end
  
  # Each gen_<...>_attacks method generates an array of bitboards, 
  # one per square, that shows what sqares a piece can reach.
  # These objects are needed for rook, bishop, knight, king, white pawn
  # and black pawn. Queen isn't needed because it is simply rook | bishop

  # The rook
  def self.gen_rook_attacks(i,j)
    @@rook_attacks[i*8+j] = Bitboard.new(@@row_attacks[i] | @@col_attacks[j])
  end
  
  # The bishop  
  def self.gen_bishop_attacks(i,j)
    # Get all paths k steps diagonally from the current position
    n = i*8+j # n : bit index of [i,j]
    @@bishop_attacks[n] = Bitboard.new(Bitboard::Mask[n])
    path = 0..7
    for k in path
      p1 = [i-k,j-k]
      p2 = [i-k,j+k]
      p3 = [i+k,j-k]
      p4 = [i+k,j+k]
      # ignore those paths that are off the edge of the board
      [p1, p2, p3, p4].each do |poss| 
        if (path === poss[0] && path === poss[1])
          @@bishop_attacks[n] |= (Bitboard::Mask[poss[0]*8 + poss[1]]) 
        end
      end
    end    
  end

  # The knight  
  def self.gen_knight_attacks(i,j)
    n = i*8+j # n : bit index of [i,j]
    # current square
    @@knight_attacks[n] = Bitboard.new(Bitboard::Mask[n])
  
    # knight moves 1,2 or 2,1  
    #   - filter positions off the board
    @@knight_attacks[n] |= Bitboard::Mask[8*(i-2) + j-1] if i>1 && j>0
    @@knight_attacks[n] |= Bitboard::Mask[8*(i-2) + j+1] if i>1 && j<7
    @@knight_attacks[n] |= Bitboard::Mask[8*(i-1) + j-2] if i>0 && j>1
    @@knight_attacks[n] |= Bitboard::Mask[8*(i-1) + j+2] if i>0 && j<6
    @@knight_attacks[n] |= Bitboard::Mask[8*(i+1) + j-2] if i<7 && j>1
    @@knight_attacks[n] |= Bitboard::Mask[8*(i+1) + j+2] if i<7 && j<6
    @@knight_attacks[n] |= Bitboard::Mask[8*(i+2) + j-1] if i<6 && j>0
    @@knight_attacks[n] |= Bitboard::Mask[8*(i+2) + j+1] if i<6 && j<7
  end
  
  # The king
  def self.gen_king_attacks(i,j)
    n = i*8+j # n : bit index of [i,j]
  
    # current square
    @@king_attacks[n] = Bitboard.new(Bitboard::Mask[n])
  
    # king moves 1 square in any direction
    #   - filter positions off the board
    @@king_attacks[n] |= Bitboard::Mask[n-9] if i>0 && j>0
    @@king_attacks[n] |= Bitboard::Mask[n-8] if i>0 
    @@king_attacks[n] |= Bitboard::Mask[n-7] if i>0 && j<7
    @@king_attacks[n] |= Bitboard::Mask[n-1] if j>0
    @@king_attacks[n] |= Bitboard::Mask[n+1] if j<7
    @@king_attacks[n] |= Bitboard::Mask[n+7] if i<7 && j>0
    @@king_attacks[n] |= Bitboard::Mask[n+8] if i<7 
    @@king_attacks[n] |= Bitboard::Mask[n+9] if i<7 && j<7
  end
  
  # The pawns. NB white and black pawn moves are distinct 
  # Also the capturing and movement need distinct structure in the move generator
  def self.gen_pawn_attacks(i,j)
    # n : bit index of [i,j]
    n=8*i+j 
    # pawns cannot be on row 0 or 7 - as they MUST promote
    if i==0 || i == 7 
      @@pawn_attacks[:white][n] = Bitboard.new 
      @@pawn_attacks[:black][n] = Bitboard.new
      return
    end
    
    # current square 
    @@pawn_attacks[:white][n] = Bitboard.new(Bitboard::Mask[n])
    @@pawn_attacks[:black][n] = Bitboard.new(Bitboard::Mask[n])
    
    # i == 7 is pre-filtered so no need to test that 1 square forward jumps off the board
    # pawns can take an opponent diagonally
    @@pawn_attacks[:white][n] |= Bitboard::Mask[n+7] if j>0
    @@pawn_attacks[:white][n] |= Bitboard::Mask[n+9] if j<7
    # pawns on the first row (7<n<16) get to move 2 squares
  
    # i == 0 is pre-filtered so no need to test that 1 square back jumps off the board
    # pawns can take an opponent diagonally
    @@pawn_attacks[:black][n] |= Bitboard::Mask[n-7] if j<7
    @@pawn_attacks[:black][n] |= Bitboard::Mask[n-9] if j>0
    # pawns on the 7th row (48<n<56) get to move 2 squares
    
  end
  
  # initialise the attack bitboards 
  Move.gen_attacks
  
  Attacks = { :king   => @@king_attacks,
              :queen  => @@rook_attacks | @@bishop_attacks,
              :rook   => @@rook_attacks,
              :bishop => @@bishop_attacks,
              :knight => @@knight_attacks,
              :pawn   => @@pawn_attacks
            }
  
end  
