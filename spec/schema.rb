ActiveRecord::Schema.define(:version => 1) do
    create_table :log_activities, :force => true do |t|
    #t.references :site
    #t.references :section

    t.references :author, :polymorphic => true
    #t.string     :author_name, :limit => 40
    #t.string     :author_email, :limit => 40
    #t.string     :author_homepage

    t.string :actions
    t.integer :object_id
    t.string :object_type, :limit => 15
    t.text :object_attributes
    t.datetime :created_at, :null => false
  end
  create_table :users do |t|
    t.string  :login
  end
  create_table :groups do |t|
    t.string  :name
  end
  create_table :memberships do |t|
    t.integer :user_id
    t.integer :group_id
  end
  create_table :posts do |t|
    t.integer :author_id
    t.boolean :private
    t.string  :title
  end
end