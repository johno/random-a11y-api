class Combo < ApplicationRecord
  has_many :votes, inverse_of: :combo

  validate :colors_are_hex

  def as_json(opts = {})
    return super unless opts[:include_votes] || opts[:include_vote_counts]

    if opts[:include_vote_counts]
      super.merge({
        up: votes.where(value: true).count,
        down: votes.where(value: false).count
      })
    else
      super.merge({
        votes: votes,
        up_votes: votes.where(value: true),
        down_votes: votes.where(value: false)
      })
    end
  end

  private

  def colors_are_hex
    unless Iz.hex_color?(color_one) && Iz.hex_color?(color_two)
      errors.add(:base, 'colors must be hexadecimal')
    end
  end
end
