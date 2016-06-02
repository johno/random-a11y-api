class Vote < ApplicationRecord
  belongs_to :combo, inverse_of: :votes, counter_cache: true
  validates :combo, presence: true
end
