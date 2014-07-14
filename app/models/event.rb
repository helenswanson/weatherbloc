class Event < ActiveRecord::Base
  validates :title, presence: true
  validates :category1, presence: true
  validates :description, presence: true
  validates :available_seats, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true

  has_many :hosts
  has_many :attendees
  has_many :reviews

  # def self.search(search)
  #   if search
  #     where('description ILIKE ?', "%#{search}%")
  #   else
  #     find(:all)
  #   end
  # end
end
