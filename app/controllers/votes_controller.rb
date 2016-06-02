class VotesController < ApplicationController
  before_action :set_combo

  def create
    if @combo.present? && @combo.valid?
      vote = @combo.votes.build
      vote.value = params.require(:vote).permit(:value)[:value]
      vote.save
      render json: {
        combo: @combo.as_json,
        vote: vote.as_json
      }, status: :created
    else
      render json: {
        message: 'Please provide a valid color combination'
      }, status: :unprocessable_entity
    end
  end

  private

  def set_combo
    combo = params.permit(:combo) || []
    puts combo.inspect
    if combo.length == 2
      @combo = Combo.where(
        color_one: combo,
        color_two: combo
      ).first

      @combo = Combo.create(
        color_one: combo[0]
        color_two: combo[1]
      ) if @combo.blank?
    end
  end
end
