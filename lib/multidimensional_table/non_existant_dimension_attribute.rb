module MultidimensionalTable
  class NonExistantDimensionAttribute < StandardError
    attr_accessor :attribute
    def initialize(attribute)
      @attribute = attribute
    end

    def to_s
     "Nonexistan dimension attribute :#@attribute"
    end
  end
end
