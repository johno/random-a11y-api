class StatsController < ApplicationController
  def index
    render json: {
      combos: Combo.count,
      votes: Vote.count,
      up_votes: Vote.where(value: true).count,
      down_votes: Vote.where(value: false).count
    }
  end
end
