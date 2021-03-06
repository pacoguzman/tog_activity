class CreateActivitiesTable < ActiveRecord::Migration
  def self.up
    create_table :activities, :force => true do |t|
      t.integer    :author_id, :references => :users
      t.string     :actions
      t.integer    :object_id, :references => nil
      t.string     :object_type, :limit => 15
      t.text       :object_attributes
      t.datetime   :created_at, :null => false
    end

    add_index :activities, :author_id
    add_index :activities, [:object_id, :object_type]
  end

  def self.down
    drop_table :log_activities
  end
end
