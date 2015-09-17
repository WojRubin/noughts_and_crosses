class Io
  X_length = 3
  Y_length = 3


  def input(validate=nil)
    data = gets
    if validate && data
      valid_obj = Validator.new
      validator = valid_obj.method(validate)
      valid_data = validator.call(data)
      if valid_data
        return valid_data
      else
        puts_message valid_obj.message
        return false
      end
    end
  end

  def puts_message text
    puts text
  end

  def puts_screen arr
    puts print_screen(arr)
  end

  def print_screen(arr)
    output = ''
    for y in 0..(Y_length-1)
      output << ' ' if y == 0
      (1..X_length).map{|n| output << ' ' + n.to_s + '  '} if y == 0
      output << "\n" if y == 0
      output << " --- --- ---\n" if [1,2].include?(y)
      for x in 0..(X_length-1)
        output << y.to_letter << ' ' if x == 0
        output << ' | ' if [1,2].include?(x)
        output << find_symbol( arr, y ,x)
        output << "\n" if x == 2
      end
    end
    output
  end

private

  def find_symbol arr, y, x
    case arr[y][x]
    when true
      'x'
    when false
      'o'
    else
      ' '
    end
  end
end