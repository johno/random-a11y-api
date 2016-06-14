class CombosController < ApplicationController
  before_action :set_page_options, only: :index

  def index
    @combos = filter_by_hex_param(Combo.all)
                .offset((@page-1) * @per_page)
                .limit(@per_page)
                .order(created_at: :desc)

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

  def filter_by_hex_param(combos)
    return combos unless params[:hex].present?

    hex = params[:hex].starts_with?('#') ? params[:hex] : "\##{params[:hex]}"

    combos.where(color_one: hex).or(Combo.where(color_two: hex))
  end

  def set_page_options
    @per_page = (params[:per_page] || 50).to_i
    @per_page = 1000 if @per_page > 1000 || @per_page.zero?

    @page = (params[:page] || 1).to_i
  end
end
