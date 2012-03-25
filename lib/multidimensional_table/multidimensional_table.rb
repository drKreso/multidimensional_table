require 'multidimensional_table/non_existant_dimension_attribute'
require 'multidimensional_table/non_valid_dimension'

module MultidimensionalTable

  def initialize
    set_dimensions(dimensions)
    data
  end

  def set_dimensions(map)
    @dimensions = map
    check_duplicates(map)
    @dimensions.each do |key, value|
      value.each do |possible_value|
        Kernel.class_eval do
        define_method possible_value do |value = nil,  &block|
          if value.nil? && !block.nil?
            @index_level += 1
            @context[@index_level] = "@attributes[:#{key}] == :#{possible_value}" 
            begin
              block.call
            rescue NoMethodError => e
              raise NonExistantDimensionAttribute.new(e.name)
            end
            @index_level -= 1
          elsif !value.nil?
            context = (1..@index_level).reduce([]) { |context, level| context << @context[level] }
            @table_rules[value] = context << ["@attributes[:#{key}] == :#{possible_value}"]  
          end
        end
        end
      end
    end
  end

  def check_duplicates(map)
    list = {}
    combined = map.each_value.reduce([]) { |all, value| all << value }.flatten
    combined.each do |item|
      if list[item].nil? 
        list[item] = 1
      else
        list[item] = list[item] + 1
      end
    end
    duplicates = list.select { |key, value| key if value > 1 }
    if duplicates != {}
      non_valid_dimensions = {}
      duplicates.each_key do |duplicate|
        non_valid_dimensions[duplicate] = []
        map.each do |key,value|
          non_valid_dimensions[duplicate] << key if value.include?(duplicate)
        end
      end
      raise NonValidDimension, non_valid_dimensions
    end
  end

  def update_attributes(attrs)
    attrs.each do |key, value| @attributes[key] = value end
  end

  def table_result
    @table_rules.each { |key, condition| return key if eval(condition.join(' && ')) == true }
  end

  def table_data
    @context = []
    @table_rules = {}
    @attributes ||= {}
    @index_level = 0
    yield
  end

  def dimensions
    @dimensions ||= {}
  end

end
