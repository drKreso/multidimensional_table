require 'multidimensional_table/multidimensional_table'


module MultidimensionalTable
  describe MultidimensionalTable do
    context 'basic setup' do
      it 'knows dimenions it has' do
        subject.extend(MultidimensionalTable)
        subject.set_dimensions ( { :material => [:potassium, :coal, :sugar] })
        subject.dimensions[:material].should == [:potassium, :coal, :sugar]
      end

      it 'creates methods for dimensions' do
        subject.extend(MultidimensionalTable)
        subject.set_dimensions ( { :material => [:potassium, :coal, :sugar] })
        subject.respond_to?(:potassium).should == true
        subject.respond_to?(:coal).should == true
        subject.respond_to?(:sugar).should == true
      end

      it 'should be able to find data from table' do
        subject.extend(MultidimensionalTable)
        subject.set_dimensions ( { :material => [:potassium, :coal, :sugar] })
        subject.table_data do
          subject.coal '8t' 
          subject.sugar '9t' 
        end
        subject.update_attributes(:material => :coal)
        subject.table_result.should == '8t'
        subject.update_attributes(:material => :sugar)
        subject.table_result.should == '9t'
      end
    end

    context 'two dimensional' do
      before(:each) do
        subject.extend(MultidimensionalTable)
        subject.set_dimensions ( { :material => [:potassium, :coal, :sugar], :city => [:zagreb, :zadar] })
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
      end

      it 'should be able to pinpoint coal in zagreb' do
        subject.update_attributes(:material => :coal, :city => :zagreb)
        subject.table_result.should == '8t'
      end

      it 'should be able to pinpoint sugar in zadar' do
        subject.update_attributes(:material => :sugar, :city => :zadar)
        subject.table_result.should == '2t'
      end
    end

    context 'three dimensional' do
      before(:each) do
        subject.extend(MultidimensionalTable)
        subject.set_dimensions ( { :material => [:potassium, :coal, :sugar],
          :city => [:zagreb, :zadar],
          :time_of_day => [:morning, :evening] } )
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
      end

      it 'should be able to pinpoint coal in zagreb at evening' do 
        subject.update_attributes(:material => :coal, :city => :zagreb, :time_of_day => :evening)
        subject.table_result.should == '4t'
      end

      it 'should be able to pinpoint sugar in zagreb at morning' do 
        subject.update_attributes(:material => :sugar, :city => :zagreb, :time_of_day => :morning)
        subject.table_result.should == '9t'
      end

      it 'should be able to pinpoint sugar in zadar' do 
        subject.update_attributes(:material => :sugar, :city => :zadar)
        subject.table_result.should == '2t'
      end
    end

    it 'should complain if dimension does not exist' do
      subject.extend(MultidimensionalTable)
      subject.set_dimensions( { :material => [:potassium, :coal, :sugar],
        :city => [:zagreb, :zadar],
        :time_of_day => [:morning, :evening] })

      expect do
        subject.table_data do
          subject.zagreb do
            subject.morning do
              subject.coal_error '8t' 
              subject.sugar '9t' 
            end
          end
        end
      end.to raise_error(NonExistantDimensionAttribute, 'Nonexistan dimension attribute :coal_error')
    end

  end
end
