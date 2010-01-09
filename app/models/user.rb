class User < ActiveRecord::Base

  has_many :activities, :foreign_key => :author_id
end