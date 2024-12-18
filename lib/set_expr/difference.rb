class Difference
  attr_reader :included, :excluded

  def initialize included, excluded # 둘 다 set_expr 타입을 받는다
    @included = included
    @excluded = excluded
  end

  def includes date
    included.includes(date) and !excluded.includes(date)
  end

  def excludes date
    excluded.includes(date)
  end
end
