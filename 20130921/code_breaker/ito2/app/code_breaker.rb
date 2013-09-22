class CodeBreaker
  def initialize(answer_code)
    @answer_code = answer_code
  end
  
  def guess(code)
    params = [@answer_code, code].map{|c| to_code_chars(c)}
    test_match(*test_exact_match(*params)).first.map(&:mark).sort.join
  end

  private

  def test_exact_match(chars, other_chars)
    exec_test(chars, other_chars, :zip, '+')
  end

  def test_match(chars, other_chars)
    exec_test(chars, other_chars, :product, '-')
  end

  def exec_test(chars, other_chars, collection_method_name, mark_char)
    chars.send(collection_method_name, other_chars) do |char, other_char|
      char.test_match(other_char, mark_char)
    end
    [chars, other_chars]
  end

  def to_code_chars(code)
    code.to_s.each_char.map{|char| CodeChar.new(char) }
  end

  class CodeChar
    attr_reader :char
    attr_accessor :mark

    def initialize(char)
      @char = char
      @mark = ''
    end

    def test_match(other, mark_char)
      if [self, other].all?(&:not_marked_yet?) and self.char == other.char
        self.mark = other.mark = mark_char
      end
    end

    def not_marked_yet?
      self.mark == ''
    end
  end
end