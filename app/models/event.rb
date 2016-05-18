class Event < ActiveRecord::Base
  # belongs_to :user

  has_many :event_users, :foreign_key => :attended_event_id
  has_many :attendees, :through => :event_users

end
