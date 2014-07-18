class User < ActiveRecord::Base
  mount_uploader :profile_photo, ProfilePhotoUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true

  has_many :events, foreign_key: 'host_id'
  has_many :attendees
  has_many :reviews

  def is_attending?(event)
    #return true if user is an attendee
    attendee = Attendee.where(user: self, event: event).first
    if attendee
      true
    else
      false
    end
  end

  def attendee_for(event)
    Attendee.where(user: self, event: event).first
  end
end
