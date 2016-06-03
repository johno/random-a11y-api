class StatsController < ApplicationController
  def index
    votes_count = Vote.count
    combos_count = Combo.count

    render json: {
      combos: combos_count,
      votes: votes_count,
      votes_per_combo: combos_count / votes_count.to_f,
      up_votes: Vote.where(value: true).count,
      down_votes: Vote.where(value: false).count,
      latest_20: Combo.all.order(created_at: :desc).limit(20),
      most_active_20: Combo.all.order(votes_count: :desc).limit(20)
    }
  end
end
