class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]
  # has_many :events, :through => :event_users
  has_many :event_users, :foreign_key => 'attendee_id'
  has_many :attended_events, :through => :event_users


  belongs_to :role
  before_save :assign_role

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def admin?
    
    self.role.name == "Admin"
  end

  def regular?
    self.role.name == "Regular"
  end

  def attend!(event)
    self.event_users.create!(attended_event_id: event.id)
  end

  def attending?(event)
    event.attendees.include?(self)
  end

  def cancel!(event)
    self.event_users.find_by(attended_event_id: event.id).destroy
  end
private

  def assign_role
   self.role = Role.find_by name: "Regular" if self.role.nil? 
  end

end

