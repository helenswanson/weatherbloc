class Category < ActiveRecord::Base
  validates :name, presence: true

  has_many :categorizations
  has_many :categories, through: :categorizations

  # def self.search(search)
  #   if search
  #     where('name ILIKE ?', "%#{search}%")
  #   else
  #     find(:all)
  #   end
  # end
end
