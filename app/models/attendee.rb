class Attendee < ActiveRecord::Base
  validates :user, presence: true
  validates :event, presence: true

  belongs_to :user
  belongs_to :event
end
