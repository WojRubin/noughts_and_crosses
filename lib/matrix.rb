class Matrix
  attr_accessor :game_array, :user_game_symbol, :computer_game_symbol

  def initialize game_array, user_game_sym
    @game_array = game_array
    @user_game_symbol = user_game_sym == 'x' ? true : false
    @computer_game_symbol = !@user_game_symbol
  end

  def get_win_move
    check_block = Proc.new do |y,x|
      @matched += 1 if @game_array[y][x] == @computer_game_symbol
      @matched = 0 if @game_array[y][x] == @user_game_symbol
      @empty = [ y , x ] if @game_array[y][x] == nil
    end
    returning_block = Proc.new do |matched,empty|
      return @empty if @matched == 2
      false
    end
    check_rows check_block, returning_block
  end

  def get_blocking_move
    check_block = Proc.new do |y,x|
      @matched += 1 if @game_array[y][x] == @user_game_symbol
      @matched = 0 if @game_array[y][x] == @computer_game_symbol
      @empty = [ y , x ] if @game_array[y][x] == nil
    end
    returning_block = Proc.new do |matched,empty|
      return @empty if @matched == 2
      false
    end
    check_rows check_block, returning_block
  end

  def get_best_move
    best_position = [[1,1],[0,0],[0,2],[2,0],[2,2]].shuffle
    best_position.each do |y,x|
      return [ y , x ] if get_all_free_move.include?([y,x])
      false
    end
  end

  def get_random_free_move
    l = get_all_free_move.length
    get_all_free_move[rand(0..(l - 1))] if l > 0
  end

  def is_free_move?
    get_all_free_move.length > 0
  end

  def is_free_field? move_string
    y,x = convert_user_move move_string
    @game_array[y][x] == nil
  end

  def user_win?
    check_block = Proc.new do |y,x|
      @matched += 1 if @game_array[y][x] == @user_game_symbol
      @matched = 0 if @game_array[y][x] == @computer_game_symbol
      @empty = [ y , x ] if @game_array[y][x] == nil
    end
    returning_block = Proc.new{|matched,empty| return true if matched == 3 }
    check_rows check_block, returning_block
  end

  def computer_win?
    check_block = Proc.new do |y,x|
      @matched += 1 if @game_array[y][x] == @computer_game_symbol
      @matched = 0 if @game_array[y][x] == @user_game_symbol
      @empty = [ y , x ] if @game_array[y][x] == nil
    end
    returning_block = Proc.new{|matched,empty| return true if matched == 3 }
    check_rows check_block, returning_block
  end

  def add_user_move move_string
    @game_array = add_move(convert_user_move( move_string ), 'user')
  end

  def add_move move_arr, who_move
    symbol = who_move == 'computer' ?  @computer_game_symbol : @user_game_symbol
    @game_array[move_arr[0]][move_arr[1]] = symbol
    @game_array
  end

private 

  def check_rows check_block, returning_block
    # check row
    for y in 0..2
      @matched = 0
      for x in 0..2
        check_block.call(y,x)
      end
      returning_block.call(@matched,@empty)
    end
    
    # check col
    for x in 0..2
      @matched = 0
      for y in 0..2
        check_block.call(y,x)
      end
      returning_block.call(@matched,@empty)
    end

    # check backslash
    y = 0
    @matched = 0
    for x in 0..2
      check_block.call(y,x)
      y += 1
    end
    returning_block.call(@matched,@empty)

    # check slash
    y = 2
    @matched = 0
    for x in 0..2
      check_block.call(y,x)
      y -= 1
    end
    returning_block.call(@matched,@empty)
  end

  def convert_user_move move_string
    y = move_string[0].to_number
    x = move_string[1].to_i - 1
    [y,x]
  end

  def get_all_free_move
    @empty = []
    for y in 0..2
      for x in 0..2
        @empty << [ y , x ] if @game_array[y][x] == nil
      end
    end
    @empty
  end
end