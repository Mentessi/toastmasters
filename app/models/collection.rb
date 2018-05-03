class Collection < ApplicationRecord
  has_many :collections_topics
  has_many :topics, through: :collections_topics
end
