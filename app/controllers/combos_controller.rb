class CombosController < ApplicationController
  def index
    @combos = Combo.all.order(created_at: :desc).limit(50)
    render json: @combos
  end

  def active
    @combos = Combo.all
                   .select('combos.id, count(votes.id) AS votes_count')
                   .joins(:votes)
                   .group('combos.id')
                   .order(votes_count: :desc)

    render json: @combos.as_json(include_votes: true)
  end

  def top
    @combos = Combo.all
                   .select('combos.id, votes.value, count(votes.id) AS votes_count')
                   .joins(:votes)
                   .where(votes: { value: true })
                   .group('combos.id')
                   .order(votes_count: :desc)

    render json: @combos.as_json(include_votes: true)
  end
end
