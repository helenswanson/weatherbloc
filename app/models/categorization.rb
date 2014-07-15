class Categorization < ActiveRecord::Base
  validates :event, presence: true
  validates :category, presence: true

  belongs_to :event
  belongs_to :category
end
