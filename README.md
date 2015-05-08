# Pinas

This gem provides hierarchical listing of Philippine location. 

![Pinas](philippines.png)


## Installation

Add this line to your application's Gemfile:

    gem 'pinas'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pinas

## Setup

    $ rails g pinas:install

    $ rake db:migrate

    $ rake pinas:load_data

## Usage/Sample

The gem provides ActiveRecord model `Pinas::Location` in 4 levels of locations

    # All regions
    Pinas::Location.regions

    # All provinces
    Pinas::Location.provinces

    # All towns
    Pinas::Location.towns

    # All barangays
    Pinas::Location.barangays

Or you can get sub locations

    # get single location
    batangas_province = Pinas::Location.where(name: 'BATANGAS').first # returns Batangas Province
    
    # get all towns in Batangas
    towns = batangas_province.towns

Get location coordinates

    batangas_province.coordinates

Get formatted display

    batangas_province.formatted_display

Or you may want to extend the model

    class Location < Pinas::Location
    end


## Caveats

At the moment this gem only supports Rails 4.x using Mysql database


## TODO

* Write tests
* Support other ORM 
* Provide geo-polygons


## Contributing

1. Fork it ( https://github.com/pangkalizer/pinas/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
