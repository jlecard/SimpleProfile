class AddImageToProfile < ActiveRecord::Migration
  def self.up 
    remove_column :profiles, :image_path
    add_column :profiles, :image_file_name, :string
    add_column :profiles, :image_content_type, :string
    add_column :profiles, :image_file_size, :integer
  end
 
  def self.down
    add_column :profiles, :image_path, :string
    remove_column :profiles, :image_file_name
    remove_column :profiles, :image_content_type
    remove_column :profiles, :image_file_size
  end
end
