require 'multidimensional_table/test_class'

describe TestClass do
    context 'basic setup' do
      it 'knows dimensions it has' do
        subject.dimensions[:test_material].should == [:test_potassium, :coal, :sugar]
      end

      it 'can pinpoint right one' do
        subject.update_attributes(:test_material => :sugar)
        subject.table_result.should == '9t'
      end
    end


end

