# Linked list example
# from ruby_trunk/sample/list.rb

require "../../utils/bench"

class MyElem
  # object initializer called from Class#new
  def initialize(item)
    # @variables are instance variable, no declaration needed
    @data = item
    @succ = nil
  end

  def data
    @data
  end

  def succ
    @succ
  end

  # the method invoked by ``obj.data = val''
  def succ=(new)
    @succ = new
  end
end

class MyList
  def initialize
    @tail :: MyElem
  end

  def add_to_list(obj)
    elt = MyElem.new(obj)
    if @head
      @tail.succ = elt
    else
      @head = elt
    end
    @tail = elt
  end

  def each
    elt = @head
    while elt
      yield elt
      elt = elt.succ
    end
  end

  # the method to convert object into string.
  # redefining this will affect print.
  def to_s
    str = "<MyList:\n";
    self.each do |elt|
      # short form of ``str = str + elt.data.to_s + "\n"''
      str += elt.data.to_s + "\n"
    end
    str += ">"
    str
  end
end

class Point
  def initialize(x, y)
    @x = x; @y = y
    self
  end

  def to_s
    sprintf("%d@%d", @x, @y)
  end
end

# global variable name starts with `$'.
Bench.run [1000, 10000] do |n|

  list1 = MyList.new
  list2 = nil
  n.times {
    list1.add_to_list(10)
    list1.add_to_list(20)
    list1.add_to_list(Point.new(2, 3))
    list1.add_to_list(Point.new(4, 5))
    list2 = MyList.new
    list2.add_to_list(20)
    list2.add_to_list(Point.new(4, 5))
    list2.add_to_list($list1)
  }
  
  list1.to_s
  list2.to_s
end
