class Array
  def sum(start = 0)
    # inject(start, &:+)
    inject(start) {|value, num| value + num}
  end

  def silly
    "Returns a silly sentence"
  end
end