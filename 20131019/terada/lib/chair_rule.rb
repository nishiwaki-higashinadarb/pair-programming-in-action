require 'pry-byebug'
require 'byebug'

class ChairRule
  attr_reader :result

  def initialize orders
    number, people = parse orders
    @chairs = Array.new(number) { |i| Chair.new(i) }
    update_chairs people
    @result = @chairs.map(&:person).join
  end

  def parse orders
    [orders.split(':').first.to_i, orders.split(':').last.split(//)]
  end

  def update_chairs people
    people.each do |person|
      # byebug
      exit?(person) ?
        find_by_person(person).empty! : next_chair.update!(person)
    end
  end

  def next_chair
    # byebug
    only1_chair or both_side_empty or last_chair or primary_last_chair or empties.first
  end

  def only1_chair
    (@chairs.size < 3 or empties.size == 1 or empties.size == @chairs.size) ?
      empties.first : false
  end

  def both_side_empty
    last_id = @chairs.size - 1
    empties.each do |chair|
      return chair if (1..(last_id - 1)).include? chair.id and right_chair(chair).empty? and left_chair(chair).empty?
    end
    false
  end

  def last_chair
    last_id = @chairs.size - 1
    empties.each do |chair|
      return chair if chair.id == last_id and left_chair(chair).empty?
    end
    false
  end

  def primary_last_chair
    last_id = @chairs.size - 1
    empties.each do |chair|
      return chair if chair.id == last_id
    end
    false
  end

  def exit? person
    person == person.downcase
  end

  def find_by_id id
    @chairs.find{ |chair| chair.id == id }
  end

  def find_by_person person
    @chairs.find{ |chair| chair.person == person.upcase }
  end

  def empties
    @chairs.select{ |chair| chair.empty? }
  end

  def right_chair chair
    find_by_id(chair.id + 1)
  end

  def left_chair chair
    find_by_id(chair.id - 1)
  end

  class Chair
    attr_reader :person, :id

    def initialize id
      empty!
      @id = id
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


