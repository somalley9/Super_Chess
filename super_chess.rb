class Chesspiece

  def initialize(color, x, y)
    @active = True
    @color = color
    @x_pos = x
    @y_pos = y
    @move_num = 0
  end
  
  def move_on_board(x, y)
    if (x >= 0) && (x <= 7)
      if (y >= 0) && (y <= 7)
        return True
    return False
  end
  
  def taken()
    @active = False
  end
  
  def move(x, y)
    if move_on_board(x, y)
      @x_pos = x
      @y_pos = y
    else
      return "Move out of bounds of board."
    end
  end
  
end

class Pawn < Chesspiece

  def move_increment()
    @move_num += 1
  end
  
  def get_moves(x, y)
    if move_num >= 1
      if has_enemy(@color, x + 1, y - 1) || has_enemy(@color, x + 1, y + 1) #TODO define has_enemy in Chessboard class
        @validMoves = [[x + 1, y - 1], [x + 1, y], [x + 1, y + 1]]  #TODO switch to case to account for one or both.
      else
        @validMoves = [[x + 1, y]]
      end
    else
      if has_enemy(@color, x + 1, y - 1) || has_enemy(@color, x + 1, y + 1) #TODO define has_enemy in Chessboard class
        @validMoves = [[x + 1, y - 1], [x + 1, y], [x + 1, y + 1]] #TODO switch to case to account for one or both.
      else
        @validMoves = [[x + 1, y], [x + 2, y]]
      end
    end
    return @validMoves
  end
  
end

class Court < Chesspiece
  def initialize(color, x, y, type)
    super(color)
    super(x_pos)
    super(y_pos)
    @type = type
    
  end
  def get_moves()
    case @type
      when rook
        i = x - 8
        for i <= (x + 8)
          @validMoves << [i, y]
        end
        i = y - 8
        for i <= (y + 8)
          @validMoves << [x, i]
        end
        return @validMoves	   
      when knight
        @validMoves = [[x+2, y+1], [x+1, y+2], [x+2, y-1], [x+1, y-2],
        	       [x-2, y-1], [x-1, y-2], [x-2, y+1], [x-1, y+2]]
        return @validMoves
      when bishop  #TODO define range of moves
        @validMoves = [[x+8, y+8], [x-8, y-8], 
        	       [x+8, y-8], [x-8, y+8]]
        return @validMoves
      when queen  #TODO define range of moves
        @validMoves = [[
        return @validMoves
      when king
        @validMoves = [[x+1, y+1], [x+1,y], [x+1, y-1], 
        	       [x, y+1], [x, y-1], 
        	       [x-1, y+1], [x-1, y], [x-1, y-1]]
        return @validMoves
      else
        puts "Error: could not identify chesspiece type."
    end
    
end

class Chessboard

  def initialize()
    #TODO create piece instances
    
    board = [[wr1, wn1, wb1, wq1, wk1, wb2, wn2, wr2],
    		 [wp1, wp2, wp3, wp4, wp5, wp6, wp7, wp8],
    		 [None, None, None, None, None, None, None, None], 
    		 [None, None, None, None, None, None, None, None], 
    		 [None, None, None, None, None, None, None, None], 
    		 [None, None, None, None, None, None, None, None], 
    		 [bp1, bp2, bp3, bp4, bp5, bp6, bp7, bp8], 
    		 [br1, bn1, bb1, bq1, bk1, bb2, bn2, br2]]
  end
  
  def is_empty(x, y)
    #TODO Return false if occupied
  end
  
  def has_enemy(color, x, y)
    #TODO define has_enemy
  end
  
  def draw_board()
    #TODO create function to draw the board with active pieces.
  end
  
  def show_moves(x, y)
    #TODO show moves for the selected piece
  end
  
end
