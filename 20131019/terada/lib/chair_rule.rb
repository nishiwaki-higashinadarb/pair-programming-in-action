require 'pry-byebug'
require 'byebug'

class ChairRule
  attr_reader :result

  def initialize orders
    number, people = parse orders
    chairs = Array.new(number) { Chair.new }
    update_chairs people, chairs
    @result = chairs.map(&:person).join
  end

  def parse orders
    [orders.split(':').first.to_i, orders.split(':').last.split(//)]
  end

  def update_chairs people, chairs
    people.each do |person|
      exit?(person) ?
        search_chair(chairs, person).empty! : empty_chair(chairs).update!(person)
    end
  end

  def exit? person
    person == person.downcase
  end

  def search_chair chairs, person
    chairs.find{|chair| chair.person == person.upcase }
  end

  def empty_chair chairs
    chairs.find{ |chair| chair.empty? }
  end

  class Chair
    attr_reader :person

    def initialize
      empty!
    end

    def update! person
      @person = person
    end

    def empty!
      @person = '-'
    end

    def empty?
      @person == '-'
    end
  end
end

