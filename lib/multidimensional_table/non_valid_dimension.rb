module MultidimensionalTable
  class NonValidDimension < StandardError
    attr_accessor :duplicate
    def initialize(duplicate)
      @duplicate = duplicate
    end

    def to_s
      "Multiple definitions are not allowed : #{represent_duplicates}"
    end

    def represent_duplicates
      duplicate.map do |key, value|
         "#{key} for dimension " << value.join(' and ')
      end.join(', ')
    end
  end
end
