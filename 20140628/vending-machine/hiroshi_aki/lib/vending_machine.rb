class VendingMachine
  attr_reader :total

  def initialize
    @total = 0
  end

  def insert amount
    @total += amount
  end

  def refund
    refund_amount = @total
    @total = 0
    refund_amount
  end

  def currency_check amount
    usable_currencies = [10, 50, 100, 500, 1000]
    if usable_currencies.include?(amount)
      insert amount
    else
      amount
    end
  end
end
