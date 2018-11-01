class Post < ApplicationRecord
  validates :item, presence: true
  validates :user, presence: true
  validates :item, length: {in: 1..20} 
  belongs_to :user
end
