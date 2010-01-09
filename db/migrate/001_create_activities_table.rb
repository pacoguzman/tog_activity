class CreateActivitiesTable < ActiveRecord::Migration
  def self.up
    create_table :log_activities, :force => true do |t|
      t.references :author

      t.string     :actions
      t.integer    :object_id
      t.string     :object_type, :limit => 15
      t.text       :object_attributes
      t.datetime   :created_at, :null => false
    end
  end

  def self.down
    drop_table :log_activities
  end
end