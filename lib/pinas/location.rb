require 'awesome_nested_set'
require 'geocoder/models/active_record'

module Pinas
  class Location < ActiveRecord::Base
    extend ::Geocoder::Model::ActiveRecord

    self.table_name = "locations"

    acts_as_nested_set

    belongs_to :parent, :class_name => self.to_s

    geocoded_by :for_geocoding  
    
    after_validation :geocode 

    LEVEL =
            {
              'national'  => 0,
              'region'    => 1,
              'province'  => 2,
              'town'      => 3,
              'barangay'  => 4
            }

    scope :regions,   -> { where(location_type: 'region') }
    scope :provinces, -> { where(location_type: 'province') }
    scope :towns,     -> { where(location_type: 'town') }
    scope :barangays, -> { where(location_type: 'barangay') }

    def provinces
      descendants.where(location_type: 'province')
    end

    def towns
      descendants.where(location_type: 'town')
    end

    def barangays
      descendants.where(location_type: 'barangay')
    end

    def for_geocoding
      "#{formatted_display || name}, Philippines"  
    end

    def coordinates
      if location_type=='barangay' # erratic coordinates on barangays, lets use town 
        { lat: parent.latitude.to_f, lon: parent.longitude.to_f }
      else
        { lat: latitude.to_f, lon: longitude.to_f }
      end
    end

    def NCR?
      region.code == '130000000'
    end

    def formatted_display
      reload if persisted?
      case location_type
      when 'barangay'
        display = "#{name}, #{parent.formatted_display}"
      when 'town'
        display = NCR?? "#{name}, NCR": "#{name}, #{province.name}"
      when 'province'
        display = province.name
      end
      display.try(:titleize) 
    end

    def town
      @town ||= get_type('town')
    end

    def region
      @region ||= get_type('region')
    end

    def province
      @province ||= get_type('province')
    end

    def barangay
      @barangay ||= get_type('barangay')
    end

    def country
      @country ||= 'Philippines'
    end

    def up_level
      LEVEL.rassoc(LEVEL[location_type] - 1).try(:[], 0)
    end

    def down_level
      LEVEL.rassoc(LEVEL[location_type] + 1).try(:[], 0)
    end

    def related_location_id_maps
      Hash[ *LEVEL.keys.map { |type| [type, get_ids(type)] }.flatten ]
    end

    def ancestors
      @ancestors ||= try do
        output = []
        level_diff = get_level_diff('national', self.location_type)
        if level_diff > 0
          ancestor = self.parent
          level_diff.times do
            break if ancestor.nil?
            output << ancestor
            ancestor = ancestor.parent
          end
        end
        output
      end
    end

    private
    def get_ids(type)
      level_diff = get_level_diff(type, self.location_type)
      if level_diff >= 0
        get_type(type).id
      else
        get_child_ids(level_diff)
      end
    end

    def get_name(type)
      get_type(type).try(:name)
    end

    def get_type(type)
      level_diff = get_level_diff(type, self.location_type)
      case
        when level_diff > 0
          ancestors[level_diff-1]
        when level_diff == 0
          self
        else nil
      end
    end

    def get_child_ids(level_diff)
      if level_diff == -1

      end
    end

    def get_level_diff(type, self_type)
      LEVEL[self_type] - LEVEL[type]
    end

  end
end