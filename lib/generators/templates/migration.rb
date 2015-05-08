class CreatePinasTables < ActiveRecord::Migration
  def change
    create_table(:locations) do |t|
      t.references  :parent
      t.integer     :lft
      t.integer     :rgt
      t.string      :location_type
      t.string      :code
      t.string      :name
      t.boolean     :city,   :default => false, :null => false
      t.string      :income_class
      t.string      :urban_rural
      t.string      :district
      t.string      :postcode
      t.string      :longitude
      t.string      :latitude
      t.timestamps null: false
    end
    add_index :locations, :parent_id
    add_index :locations, :postcode
    add_index :locations, :uri
    add_index :locations, [:name, :location_type, :postcode]
  end
end