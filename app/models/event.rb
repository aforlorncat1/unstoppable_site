class Event < ActiveRecord::Base
  has_many :users, :through => :event_users
  
end
