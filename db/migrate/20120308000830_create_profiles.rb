class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :street
      t.string :country
      t.string :city
      t.string :zipcode
      t.text :description
      t.string :image_path
      t.float :latitude
      t.float :longitude
      t.boolean :gmaps
      t.timestamps
    end
  end
end
