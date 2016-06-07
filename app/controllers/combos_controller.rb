class CombosController < ApplicationController
  def index
    @combos = Combo.all.order(created_at: :desc).includes(:votes).limit(params[:per_page] || 50)
    render json: @combos.as_json(include_vote_counts: true)
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
    combo_ids = Vote.where(value: true).group(:combo_id).order('count_all DESC').limit(20).count.keys
    @combos = Combo.where(id: combo_ids)

    render json: @combos.as_json(include_votes: true)
  end
end
