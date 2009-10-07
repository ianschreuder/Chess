=begin

 A bitboard represents the squares of a chess board. 
 Each square is represented by a single bit in a 64 bit integer. 
 Bitboards are used to speed up operations but here it's done to 
 experiment using bitboards

     a  b  c  d  e  f  g  h
     ------------------------
 7  |56|57|58|59|60|61|62|63|  7
     ------------------------
 6  |48|49|50|51|52|53|54|55|  6
     ------------------------
 5  |40|41|42|43|44|45|46|47|  5
     ------------------------
 4  |32|33|34|35|36|37|38|39|  4
     ------------------------
 3  |24|25|26|27|28|29|30|31|  3
     ------------------------
 2  |16|17|18|19|20|21|22|23|  2
     ------------------------
 1  | 8| 9|10|11|12|13|14|15|  1
     ------------------------
 0  | 0| 1| 2| 3| 4| 5| 6| 7|  0
     ------------------------
     a  b  c  d  e  f  g  h

=end

class Bitboard 
  MaxValue = 0xffffffffffffffff
  MinValue = 0x0
  
  attr_reader :value
  
  Mask = [1<< 0, 1<< 1, 1<< 2, 1<< 3, 1<< 4, 1<< 5, 1<< 6, 1<< 7, 
          1<< 8, 1 <<9, 1<<10, 1<<11, 1<<12, 1<<13, 1<<14, 1<<15, 
          1<<16, 1<<17, 1<<18, 1<<19, 1<<20, 1<<21, 1<<22, 1<<23, 
          1<<24, 1<<25, 1<<26, 1<<27, 1<<28, 1<<29, 1<<30, 1<<31, 
          1<<32, 1<<33, 1<<34, 1<<35, 1<<36, 1<<37, 1<<38, 1<<39, 
          1<<40, 1<<41, 1<<42, 1<<43, 1<<44, 1<<45, 1<<46, 1<<47, 
          1<<48, 1<<49, 1<<50, 1<<51, 1<<52, 1<<53, 1<<54, 1<<55, 
          1<<56, 1<<57, 1<<58, 1<<59, 1<<60, 1<<61, 1<<62, 1<<63]
  
  # Create a new Bitboard with an optional initial value
  # raise an ArgumentError if the initial value is out of range 
  def initialize(value=0)
    raise ArgumentError, sprintf("%32x", value) + " passed\nis out of range [0x0..0xffffffffffffffff]" if value < MinValue || value > MaxValue
    @value = value
  end
  
  # Test equality against other
  #   - other is either a 64 bit integer or a Bitboard
  def ==(other)
    self.equal?(other) || @value.equal?(other) || (other.class == Bitboard && @value == other.value )
  end
  
  # Bitwise and with other returns a new Bitboard
  #   - other is either a 64 bit integer or a Bitboard
  def &(other)
    other = other.value if other.class == Bitboard
    Bitboard.new(@value & other)
  end
  
  # Bitwise or with other
  #   - other is either a 64 bit integer or a Bitboard
  def |(other)
    other = other.value if other.class == Bitboard
    Bitboard.new(@value | other)
  end
  
  # Bitwise not 
  def ~()
    notvalue = Bitboard.new
    0.upto(63){|i| notvalue.set!(i) if self.clear?(i)}
    notvalue
  end
  
  # Bitwise xor with other
  #   - other is either a 64 bit integer or a Bitboard
  def ^(other)
    other = other.value if other.class == Bitboard
    Bitboard.new(@value ^ other)
  end
  
  # Set bit n 
  def set!(n)
    @value = @value | (Mask[n])
  end

  # Clear bit n
  def clear!(n)
    @value &= (Mask[n]) ^ MaxValue
  end

  # Test if bit n is set
  def set?(n)
    (@value & Mask[n]) == Mask[n]
  end

  # Test if bit n is clear  
  def clear?(index)
    !set?(index)
  end
  
  # array of bit-index for bits that are set
  def set_bits
    bits = []
    0.upto(63) {|i| bits << i if set?(i)}
    bits
  end
  
  

end