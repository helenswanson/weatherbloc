class Event < ActiveRecord::Base
  validates :title, presence: true
  validates :description, presence: true
  validates :available_seats, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :host_id, presence: true

  belongs_to :host, class_name: 'User'
  has_many  :attendees
  has_many  :reviews
  has_many  :categorizations
  has_many  :categories, through: :categorizations

  # def self.search(search)
  #   if search
  #     where('description ILIKE ?', "%#{search}%")
  #   else
  #     find(:all)
  #   end
  # end
end
