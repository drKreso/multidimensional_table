require 'multidimensional_table/multidimensional_table'

describe MultidimensionalTable do
  it 'knows dimenions it has' do
    subject.extend(MultidimensionalTable)
    subject.dimensions = { :material => [:potassium, :coal, :sugar] }
    subject.dimensions[:material].should == [:potassium, :coal, :sugar]
  end

  it 'creates methods for dimensions' do
    subject.extend(MultidimensionalTable)
    subject.dimensions = { :material => [:potassium, :coal, :sugar] }
    subject.respond_to?(:potassium).should == true
    subject.respond_to?(:coal).should == true
    subject.respond_to?(:sugar).should == true
  end

  it 'should be able to add table data onto dimensions' do
    subject.extend(MultidimensionalTable)
    subject.dimensions = { :material => [:potassium, :coal, :sugar] }
    subject.table_data do
      subject.coal '8t' 
    end
    subject.table_rules.count.should == 1
  end

  it 'should be able to find data from table' do
    subject.extend(MultidimensionalTable)
    subject.dimensions = { :material => [:potassium, :coal, :sugar] }
    subject.table_data do
      subject.coal '8t' 
      subject.sugar '9t' 
    end
    subject.update_attributes(:material => :coal)
    subject.table_result.should == '8t'
    subject.update_attributes(:material => :sugar)
    subject.table_result.should == '9t'
  end

  it 'should be able to find data from two dimensional table' do
    subject.extend(MultidimensionalTable)
    subject.dimensions = { :material => [:potassium, :coal, :sugar], :city => [:zagreb, :zadar] }
    subject.table_data do
      subject.zagreb do
        subject.coal '8t' 
        subject.sugar '9t' 
      end
      subject.zadar do
        subject.coal '1t' 
        subject.sugar '2t' 
      end
    end
    subject.update_attributes(:material => :coal, :city => :zagreb)
    subject.table_result.should == '8t'
    subject.update_attributes(:material => :sugar, :city => :zadar)
    subject.table_result.should == '2t'
  end

  it 'should be able to find data from three dimensional' do
    subject.extend(MultidimensionalTable)
    subject.dimensions = { :material => [:potassium, :coal, :sugar],
                           :city => [:zagreb, :zadar],
                           :time_of_day => [:morning, :evening] }
    subject.table_data do
      subject.zagreb do
        subject.morning do
          subject.coal '8t' 
          subject.sugar '9t' 
        end
        subject.evening do
          subject.coal '4t' 
          subject.sugar '5t' 
        end
      end
      subject.zadar do
        subject.coal '1t' 
        subject.sugar '2t' 
      end
    end

    subject.update_attributes(:material => :coal, :city => :zagreb, :time_of_day => :evening)
    subject.table_result.should == '4t'

    subject.update_attributes(:material => :sugar, :city => :zagreb, :time_of_day => :morning)
    subject.table_result.should == '9t'

    subject.update_attributes(:material => :sugar, :city => :zadar)
    subject.table_result.should == '2t'
  end

end



