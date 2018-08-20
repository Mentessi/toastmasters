# frozen_string_literal: true
class CollectionsMembership < ApplicationRecord
  belongs_to :topic
  belongs_to :collection
end
