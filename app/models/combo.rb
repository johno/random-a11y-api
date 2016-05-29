class Combo < ApplicationRecord
  has_many :votes, inverse_of: :combo

  validate :colors_are_hex

  def up_votes
    votes.where(value: true)
  end

  def down_votes
    votes.where(value: false)
  end

  private

  def colors_are_hex
    unless Iz.hex_color?(color_one) && Iz.hex_color?(color_two)
      errors.add(:base, 'colors must be hexadecimal')
    end
  end
end
