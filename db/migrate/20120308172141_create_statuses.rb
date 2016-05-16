class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.string :message
      t.timestamp :datetime
      t.integer :profile_id

      t.timestamps
    end
  end
end
