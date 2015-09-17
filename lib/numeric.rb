class Numeric
  Abc = %w(A B C)
  def to_letter
    return "" if self < 0 || self > 2
    Abc[self]
  end
end