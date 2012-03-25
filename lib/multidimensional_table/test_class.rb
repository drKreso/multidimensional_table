require 'multidimensional_table/multidimensional_table'

class TestClass
  include MultidimensionalTable

  def initialize()
    set_dimensions({ :test_material => [:test_potassium, :coal, :sugar] })
    table_data do
      coal '8t' 
      sugar '9t' 
    end
  end
end
