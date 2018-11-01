class Chesspiece

  def initialize(color, x, y)
    @active = True
    @color = color
    @x_pos = x
    @y_pos = y
    @move_num = 0
  end
  
  def taken()
    #Flags a piece as not active as it is removed from the board
    @active = False
    if @type == "king"
      return "Y"
    end
  end
  
  def move(x, y)
    #Handles the updating of the piece in the board array, and changing the x, y coordinates in the instance
  
    #TODO change piece position in board array
    #TODO blank out old location in board array
    @x_pos = x
    @y_pos = y
	
  end
  
  def get_color()
    #Returns the color of the piece selected for enemy identification
    return @color
  end
  
  def move_increment()
  #Primarily to keep track of first move for pawns, but can also be used for game statistics
    @move_num += 1
  end
  
end

class Pawn < Chesspiece
  def initialize(color, x, y)
    super(color)
    super(x_pos)
    super(y_pos)
    super(active)
	super(move_num)
  end
  
  def get_moves(color, x, y)
    #Movement options specific to the pawn piece
    if color == white
	#Invert's white's move to match board array indexes and movement direction
      i = -1
    else
      i = 1
    end
      
    if move_num >= 1
	#Potential movements for first and subsequent movements, respectively
      if has_enemy(@color, x + 1, y + i) && has_enemy(@color, x - 1, y + i) 
        @validMoves = [[x - 1, y + i], [x, y + i], [x + 1, y + i]]
      elsif has_enemy(@color, x - 1, y + i)
        @validMoves = [[x, y + i], [x - 1, y + i]]
      elsif has_enemy(@color, x + 1, y + 1)
        @validMoves = [[x, y + i], [x + 1, y + i]]
      else
        @validMoves = [[x, y + i]]
      end
    else
      if has_enemy(@color, x + 1, y + i) && has_enemy(@color, x - 1, y + i) 
        @validMoves = [[x - 1, y + i], [x, y + i], [x + 1, y + i]]
      elsif has_enemy(@color, x - 1, y + i)
        @validMoves = [[x, y + i], [x - 1, y + i]]
      elsif has_enemy(@color, x + 1, y + i)
        @validMoves = [[x, y + i], [x + 1, y + i]]
      else
        @validMoves = [[x, y + i], [x, y + (2 * i)]]
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
    super(active)
	super(move_num)
    @type = type
  end
  
  def get_moves()
	#Creates an array of valid movements for specific court or non-pawn pieces
    case @type
      when rook
        i = y - 8
        while i <= y + 8 do
          @possMoves << [i, x]
		  i += 1
        end
        i = x - 8
        while i <= x + 8 do
          @possMoves << [y, i]
		  i += 1
        end
		@possMoves.each do |move|
		  if move_on_board(move[1], move[0])
		    @validMoves << move
		end
        return @validMoves
		end
      when knight
        @possMoves = [[x+2, y+1], [x+1, y+2], [x+2, y-1], [x+1, y-2],
        			   [x-2, y-1], [x-1, y-2], [x-2, y+1], [x-1, y+2]]
		@possMoves.each do |move|
		  if move_on_board(move[1], move[0])
		    @validMoves << move
		end
        return @validMoves
		end
      when bishop  #TODO
        @possMoves = [[x+8, y+8], [x-8, y-8], 
        			   [x+8, y-8], [x-8, y+8]]
		@possMoves.each do |move|
		  if move_on_board(move[1], move[0])
		    @validMoves << move
		end
        return @validMoves
		end
      when queen  #TODO
        i = y - 8
        while i <= y + 8 do
          @possMoves << [i, x]
		  i += 1
        end
        i = x - 8
        while i <= x + 8 do
          @possMoves << [y, i]
		  i += 1
        end
		@possMoves.each do |move|
		  if move_on_board(move[1], move[0])
		    @validMoves << move
		end
        return @validMoves
		end
      when king
        @possMoves = [[x-1, y+1], [x, y+1], [x+1, y+1], 
        			   [x-1, y], [x+1, y], 
        			   [x-1, y-1], [x, y-1], [x+1, y-1]]
        @possMoves.each do |move|
		  if move_on_board(move[1], move[0])
		    @validMoves << move
		end
		return @validMoves
		end
      else
        puts "Error: could not identify chesspiece type."
	  end
    end
    
end

class Chessboard

  def initialize()
	i = 0
	while i <= 7 do
	  #TODO doesn't work yet
	  command = "wp#{i + 1} = Pawn.new('white', #{i}, 6)"
	  eval(command)
	  i += 1
	end
	i = 0
	while i <= 7 do
	  #TODO doesn't work yet
	  command = "wp#{i + 1} = Pawn.new('white', #{i}, 6)"
	  eval(command)
	  i += 1
	end
	
	br1 = Court.new("black", 0, 0, "rook")
	bn1 = Court.new("black", 1, 0, "knight")
	bb1 = Court.new("black", 2, 0, "bishop")
	bq1 = Court.new("black", 3, 0, "queen")
	bk1 = Court.new("black", 4, 0, "king")
	bb2 = Court.new("black", 5, 0, "bishop")
	bn2 = Court.new("black", 6, 0, "knight")
	br2 = Court.new("black", 7, 0, "rook")
	
	wr1 = Court.new("white", 0, 7, "rook")
	wn1 = Court.new("white", 1, 7, "knight")
	wb1 = Court.new("white", 2, 7, "bishop")
	wq1 = Court.new("white", 3, 7, "queen")
	wk1 = Court.new("white", 4, 7, "king")
	wb2 = Court.new("white", 5, 7, "bishop")
	wn2 = Court.new("white", 6, 7, "kinght")
	wr2 = Court.new("white", 7, 7, "rook")
	
    
    @board = [[br1, bn1, bb1, bq1, bk1, bb2, bn2, br2],
    		 [bp1, bp2, bp3, bp4, bp5, bp6, bp7, bp8], 
    		 ["   ", "   ", "   ", "   ", "   ", "   ", "   ", "   "], 
    		 ["   ", "   ", "   ", "   ", "   ", "   ", "   ", "   "], 
    		 ["   ", "   ", "   ", "   ", "   ", "   ", "   ", "   "], 
    		 ["   ", "   ", "   ", "   ", "   ", "   ", "   ", "   "], 
    		 [wp1, wp2, wp3, wp4, wp5, wp6, wp7, wp8],
    		 [wr1, wn1, wb1, wq1, wk1, wb2, wn2, wr2]]
  end
  
  def menu()
    puts "Let's play Chess!"
	puts "1 - Single player against computer"
	puts "2 - Two player"
	selection = gets.chomp
	return selection
  end
  
  def move_on_board(x, y)
    #Returns true if x and y index are within the board, false otherwise
    if (x >= 0) && (x <= 7)
      if (y >= 0) && (y <= 7)
        return True
	  end
	end
    return False
  end
  
  def is_empty(x, y)
    #Returns true if x, y index is empty
    if @board[y][x] == "   "
      return True
    else
      return False
    end
  end
  
  def has_enemy(color, x, y)
    #Ran in conjunction with is_empty and returns true if piece is not the same color, thus an enemy
    if @board[y][x].get_color != color
      return True
    else
      return False
    end
  end
  
  def draw_board()
    #Draws the board, mapping the current piece layout
    puts "              Super Chess                  "
    puts "  #####-----#####-----######-----#####-----"
    puts "0 #" + @board[0][0] + "#-" + @board[0][1] + "-#" + @board[0][2] + "#-" + @board[0][3] + "-#" + @board[0][4] + "#-" + @board[0][5] + "-#" + @board[0][6] + "#-" + @board[0][7] + "-"
    puts "  #####-----#####-----######-----#####-----"
    puts "  -----#####-----#####------#####-----#####"
    puts "1 -" + @board[1][0] + "-#" + @board[1][1] + "#-" + @board[1][2] + "-#" + @board[1][3] + "#-" + @board[1][4] + "-#" + @board[1][5] + "#-" + @board[1][6] + "-#" + @board[1][7] + "#"
    puts "  -----#####-----#####------#####-----#####"
    puts "  #####-----#####-----######-----#####-----"
    puts "2 #" + @board[2][0] + "#-" + @board[2][1] + "-#" + @board[2][2] + "#-" + @board[2][3] + "-#" + @board[2][4] + "#-" + @board[2][5] + "-#" + @board[2][6] + "#-" + @board[2][7] + "-"
    puts "  #####-----#####-----######-----#####-----"
    puts "  -----#####-----#####------#####-----#####"
    puts "3 -" + @board[3][0] + "-#" + @board[3][1] + "#-" + @board[3][2] + "-#" + @board[3][3] + "#-" + @board[3][4] + "-#" + @board[3][5] + "#-" + @board[3][6] + "-#" + @board[3][7] + "#"
    puts "  -----#####-----#####------#####-----#####"
    puts "  #####-----#####-----######-----#####-----"
    puts "4 #" + @board[4][0] + "#-" + @board[4][1] + "-#" + @board[4][2] + "#-" + @board[4][3] + "-#" + @board[4][4] + "#-" + @board[4][5] + "-#" + @board[4][6] + "#-" + @board[4][7] + "-"
    puts "  #####-----#####-----######-----#####-----"
    puts "  -----#####-----#####------#####-----#####"
    puts "5 -" + @board[5][0] + "-#" + @board[5][1] + "#-" + @board[5][2] + "-#" + @board[5][3] + "#-" + @board[5][4] + "-#" + @board[5][5] + "#-" + @board[5][6] + "-#" + @board[5][7] + "#"
    puts "  -----#####-----#####------#####-----#####"
    puts "  #####-----#####-----######-----#####-----"
    puts "6 #" + @board[6][0] + "#-" + @board[6][1] + "-#" + @board[6][2] + "#-" + @board[6][3] + "-#" + @board[6][4] + "#-" + @board[6][5] + "-#" + @board[6][6] + "#-" + @board[6][7] + "-"
    puts "  #####-----#####-----######-----#####-----"
    puts "  -----#####-----#####------#####-----#####"
    puts "7 -" + @board[7][0] + "-#" + @board[7][1] + "#-" + @board[7][2] + "-#" + @board[7][3] + "#-" + @board[7][4] + "-#" + @board[7][5] + "#-" + @board[7][6] + "-#" + @board[7][7] + "#"
    puts "  -----#####-----#####------#####-----#####"
    puts "    0    1    2    3     4    5    6    7  "
  end
  
  def show_moves()
    #Option available to show possible moves for the piece selected
    puts @validMoves
  end
  
end

chessboard = Chessboard.new()

quit = "N"
gameover = "N"
while quit != "Y" || quit != "y" || gameover != True do
  
  chessboard.draw_board()
  
  movement = False
  while movement == False do
    color = "white"
    puts "White's move. Select your piece by it's name on the board, for example 'wq1' for white's queen: "
	#TODO need to verify user input is a piece prior to moving on
    piece = gets.chomp
    if (eval(piece + '.get_color')) != color
      puts "That piece does not belong to you."
      continue
    end
    
    puts "M - Select the position you would like to move to using the indexes on the board. "
	puts "S - Show available moves for the piece selected. "
	puts "C - Select a different piece to move. "
	selection = gets.chomp
	if selection == "S" || selection == "s"
	  show_moves()
	  continue
	elsif selection == "C" || selection == "c"
	  continue
	else
      puts "X-axis: "
      x = gets.chomp
      puts "Y-axis: "
      y = gets.chomp
    end
    #TODO finish rest of verifying move
	
	#TODO establish movement
	movement = True
  end
	#TODO repeat ^^^ for black
  gameover = True
end
