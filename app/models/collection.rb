class Collection < ApplicationRecord
  has_many :collections_topics
  has_many :topics, through: :collections_topics
  belongs_to :user
  validates :name, presence: true
end
