# MultidimensionalTable

--------
I ended up not liking implementation, API and name so I changed all three result is in md_data gem.
--------

This is a product of a coding kata. I wanted an easy way to describe multidimensional table
but only using ruby code and not some sort of .yaml or other custom format that you have to parse in some way.

For example:

```
1994      
  BuenosAires
    Coal
      19t
    Potassium
      5t
1995 
  BuenosAires
    Coal  
      8t
    Potassium
      6t
```

Then if I say I need to get Coal in Buenos Aires in 1995 I wan't to get 8t. The idea is to make easy DSL to 
describe the same thing in pure Ruby.

## Installation

Add this line to your application's Gemfile:

    gem 'multidimensional_table'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install multidimensional_table

## Usage
```
class MaterialConsumption
  include MultidimensionalTable

  def dimensions
    {
     :year => [:year_1994, :year_1995],
     :city => [:buenos_aires],
     :material => [:coal, :potassium]
    }
  end

  def data
    table_data do
      year_1994 do
        buenos_aires do
          coal '8t' 
          potassium '5t' 
        end
      end
      year_1995 do
        buenos_aires do
          coal '8t' 
          potassium '6t' 
        end
      end
    end
  end

end

mt = new MaterialConsumption
mt.update_attributes(:year => :year_1994, :city => :buenos_aires, :material => :coal)
mt.table_result #=> '8t'
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
