class Chesspiece

  def initialize(color, x, y)
    @active = True
    @color = color
    @x_pos = x
    @y_pos = y
    @move_num = 0
  end
  
  def move_on_board(x, y)
    if (x >= 0) && (x <= 8)
      if (y >= 0) && (y <= 8)
        return True
    return False
  end
  
  def taken()
    @active = False
  end
  
  def move
    if move_on_board(x, y)
      @x_pos = x
      @y_pos = y
    end
  end
  
end

class Pawn < Chesspiece

  def move_increment
    @move_num += 1
  end
  
  def valid_move(x, y)
    if move_num >= 1
      if has_enemy(color, x + 1, y - 1) && has_enemy(color, x + 1, y + 1) #TODO define has_enemy in Chessboard class
        validMoves = [[x + 1, y - 1], [x + 1, y], [x + 1, y + 1]]
      else
        validMoves = [[x + 1, y]]
      end
    else
      if has_enemy(color, x + 1, y - 1) && has_enemy(color, x + 1, y + 1) #TODO define has_enemy in Chessboard class
        validMoves = [[x + 1, y - 1], [x + 1, y], [x + 1, y + 1]]
      else
        validMoves = [[x + 1, y], [x + 2, y]]
      end
    end
  end
  
end

class Court
  #TODO add methods
end

class Chessboard

  def initialize()
    #TODO setup the board with pieces as part of initialization
  end
  
  def has_enemy(color, x, y)
    #TODO define has_enemy
  end
  
end
