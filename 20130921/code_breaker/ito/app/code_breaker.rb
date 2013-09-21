class CodeChar
  attr_reader :char
  attr_writer :found

  def initialize(char)
    @char = char
    @found = false
  end

  def are_you_there?(other)
    if self.not_found_yet? and other.not_found_yet? and self.char == other.char
      self.found = other.found = true
    end
  end

  def not_found_yet?
    not @found
  end
end

class CodeBreaker
  def initialize(answer_code)
    @answer_chars = to_code_chars(answer_code)
  end
  
  def guess(code)
    ''.tap do |mark|
      to_code_chars(code).each_with_index {|code_char, index|
        mark << '+' if @answer_chars[index].are_you_there?(code_char)
      }.product(@answer_chars) {|code_char, answer_char|
        mark << '-' if answer_char.are_you_there?(code_char)
      }
    end
  end

  private

  def to_code_chars(code)
    code.to_s.split('').map{|char| CodeChar.new(char) }
  end
end
