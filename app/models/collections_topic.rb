class CollectionsTopic < ApplicationRecord
  belongs_to :topic
  belongs_to :collection
end
