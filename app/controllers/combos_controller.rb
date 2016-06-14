class CombosController < ApplicationController
  before_action :set_page_options, only: :index

  def index
    @combos = Combo.order(id: :desc).offset((@page-1) * @per_page).limit(@per_page)
    render json: @combos.as_json(include_vote_counts: true)
  end

  def active
    @combos = Combo.all
                   .limit(100)
                   .select('combos.id, count(votes.id) AS votes_count')
                   .joins(:votes)
                   .group('combos.id')
                   .order(votes_count: :desc)

    render json: @combos.as_json(include_votes: true)
  end

  def top
    combo_ids = Vote.where(value: true).group(:combo_id).order('count_all DESC').limit(100).count.keys
    @combos = Combo.where(id: combo_ids)

    render json: @combos.as_json(include_votes: true)
  end

  private

  def set_page_options
    @per_page = (params[:per_page] || 50).to_i
    @per_page = 1000 if @per_page > 1000 || @per_page.zero?

    @page = (params[:page] || 1).to_i
  end
end
