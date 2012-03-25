module MultidimensionalTable

  attr_reader :table_rules

  @context = []
  @table_rules = {}
  @attributes ||= {}
  @index_level = 0

  def dimensions=(map)
    @dimensions = map
    @dimensions.each do |key, value|
      value.each do |possible_value|
        define_method possible_value do |value = nil,  &block|
          if value.nil? && !block.nil?
            @index_level += 1
            @context[@index_level] = "@attributes[:#{key}] == :#{possible_value}" 
            block.call
            @index_level -= 1
          elsif !value.nil?
            context = (1..@index_level).reduce([]) do |context, level|
              context << @context[level]
            end
            @table_rules[value] = context << ["@attributes[:#{key}] == :#{possible_value}"]  
          end
        end
      end
    end
  end

  def update_attributes(attrs)
    attrs.each do |key, value|
      @attributes[key] = value
    end
  end

  def table_result
    @table_rules.each do |key, condition| 
      if class_eval(condition.join(' && ')) == true
        return key
      end
    end
  end

  def table_data(&block)
    @context = []
    block.call
  end

  def dimensions
    @dimensions ||= {}
  end

end
