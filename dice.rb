class Dice
  attr_reader :rolls, :value

  def initialize(string)
    n, sides = string.split("d").map(&:to_i)
    # ooh, unless custom die
    # or exploding
    @results = []
    n.times do
      @results << rand(sides) + 1
    end
    @value = @results.reduce(:+)
  end

  def +(x)
    @value + ( x.is_a?(Dice) ? x.value : x )
  end

  def *(x)
    @value * ( x.is_a?(Dice) ? x.value : x )
  end

  def /(x)
    @value / ( x.is_a?(Dice) ? x.value : x )
  end

  def h(n=1)
    raise "didn't roll #{n} dice" if n > @results.length
    @results.sort.reverse.take(n).reduce(:+)
  end

  def l(n=1)
    raise "didn't roll #{n} dice" if n > @results.length
    @results.sort.take(n).reduce(:+)
  end
end
