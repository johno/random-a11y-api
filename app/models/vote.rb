class Vote < ApplicationRecord
  belongs_to :combo, inverse_of: :votes
  validates :combo, presence: true
end
