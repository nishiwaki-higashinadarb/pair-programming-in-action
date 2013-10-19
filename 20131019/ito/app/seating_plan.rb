class SeatingPlan
  def self.sit_and_leave(input)
    self.new(*input.split(':')).sit_and_leave
  end

  def initialize(chair_count, people)
    @chairs = create_chairs(chair_count.to_i)
    @people = people.chars
  end

  def sit_and_leave
    @people.each {|person| sit_or_leave(person) }
    @chairs.join
  end

  private

  def sit_or_leave(person)
    person.love_to_sit? ? find_best_vacant_chair.sit(person) : find_seated_chair(person).leave
  end

  def create_chairs(chair_count)
    Array.new(chair_count){ Chair.new }.tap(&method(:refer_neighbors))
  end
  
  def refer_neighbors(chairs)
    chairs.each_cons(2) do |left_chair, right_chair|
      right_chair.prev_chair = left_chair
      left_chair.next_chair = right_chair
    end
  end

  def find_best_vacant_chair
    @chairs.reject(&:seated?).max_by(&:side_vacant_count)
  end

  def find_seated_chair(person)
    @chairs.find{|chair| chair.seated_by?(person) }
  end

  class ::String
    def love_to_sit?
      self.match(/[A-Z]/)
    end
  end

  class Chair
    attr_accessor :prev_chair, :next_chair
    attr_reader :seated_person

    def sit(person)
      @seated_person = person
    end

    def leave
      @seated_person = nil
    end

    def seated?
      !seated_person.nil?
    end

    def seated_by?(person)
      seated_person == person.upcase
    end

    # 両側空き = 2, 片側空き = 1, 両側空きなし = 0
    def side_vacant_count
      [prev_chair, next_chair].count{|chair| chair.nil? || !chair.seated? }
    end

    def to_s
      seated_person || '-'
    end
  end
end