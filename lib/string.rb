class String
  Array = %w{ a b c }
  def to_number
    return '' unless Array.include?(self.downcase)
    Array.index(self.downcase)
  end
end