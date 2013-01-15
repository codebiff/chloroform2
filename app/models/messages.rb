class Messages < ActiveRecord::Base
  belongs_to :user_id
  attr_accessible :data
end
