require 'multidimensional_table/multidimensional_table'

class TestClass
  include MultidimensionalTable

  def dimensions
    { :test_material => [:test_potassium, :coal, :sugar] }
  end

  def data
    table_data do
      coal '8t' 
      sugar '9t' 
    end
  end
end
