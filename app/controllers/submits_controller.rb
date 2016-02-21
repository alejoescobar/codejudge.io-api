class SubmitsController < ApplicationController

  def show
    @challenge = Challenge.find(params[:challenge_id])
    @submit = Submit.find(params[:id])
  end

  def new
    @challenge = Challenge.find(params[:challenge_id])
    @submit = Submit.new
  end

  def create
    @challenge = Challenge.find(params[:challenge_id])
    @submit = Submit.new(submit_params.merge(status: "pending", challenge: @challenge))
    if @submit.save
      CodeEvaluatorJob.perform_later(@submit)
      flash[:notice] = "Your answer is being analyzed, reload in a bit to see the results"
      redirect_to challenge_submit_path(@challenge, @submit)
    else
      render :new
    end
  end

  private

  def submit_params
    params.require(:submit).permit(:code, :language)
  end

end
