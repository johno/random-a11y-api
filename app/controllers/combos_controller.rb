class CombosController < ApplicationController
  def index
    @combos = Combo.all.order(created_at: :desc).limit(50)
    render json: @combos
  end

  def top
    @combos = Combo.select('*', 'SELECT count(1) AS total_votes FROM votes WHERE votes.combo_id = combo.id').order('total_votes')
    render json: @combos.as_json(include_votes: true)
  end
end
