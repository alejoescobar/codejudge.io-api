# == Schema Information
#
# Table name: challenges
#
#  id         :integer          not null, primary key
#  name       :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  uid        :string
#

class ChallengesController < ApplicationController
  def index
    @challenges = Challenge.all
  end
  def new
    @challenge = Challenge.new
  end
  def create
    @challenge = Challenge.new(challenge_params)
    @challenge.save
    redirect_to @challenge
  end
  def show
    @challenge = Challenge.find(params[:id])
  end
  def edit
    @challenge = Challenge.find(params[:id])
  end
  def update
    @challenge = Challenge.find(params[:id])
    if @challenge.update(challenge_params)
      redirect_to @challenge
    else
      render 'edit'
    end
  end
  def destroy
    @challenge = Challenge.find(params[:id])
    @challenge.destroy
    redirect_to challenges_path
  end
  private
  def challenge_params
    params.require(:challenge).permit(:name)
  end
end
