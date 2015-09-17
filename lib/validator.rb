class Validator
  attr_accessor :message

  def move move_string
    @message = "Wrong data!. Type for example: a1, b2, c3"
    return move_string[0..1] if move_string[0] =~ (/[a-cA-C]/) && move_string[1] =~ (/[1-3]/)
    false
  end

  def gamer_symbol gamer_symbol_string
     @message = "Wrong data!. Type o x"
    return gamer_symbol_string[0] if ['o','x'].include?(gamer_symbol_string[0])
    false
  end

  def who_first who_first_string
     @message = "Wrong data!. Type c/u"
    return who_first_string[0] if ['c','u'].include?(who_first_string[0])
    false
  end 

  def play_again again_string
    return again_string[0] if ['y','n'].include?(again_string[0])
    false
  end
end