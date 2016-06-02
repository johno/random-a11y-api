class CombosController < ApplicationController
  def index
    @combos = Combo.all.order(created_at: :desc).limit(50)
    render json: @combos
  end

  def top
    @combos = Combo.all.includes(:votes)
                   # Order by associated votes with value: false
                   .order(created_at: :desc).limit(50)
    render json: @combos.as_json(include_votes: true)
  end
end
