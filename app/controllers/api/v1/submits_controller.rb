class Api::V1::SubmitsController < Api::V1::ApiController
  before_action :authenticate_with_token!, only: [:create]
  respond_to :json

  def create
    challenge = Challenge.find(params[:challenge_id])
    submit = challenge.submits.build(submit_params.merge(status: :pending))
    if submit.save
      CodeEvaluatorJob.perform_later(submit)
      head :created
    else
      render json: {errors: submit.errors}, status: :bad_request
    end
  end

  private

    def submit_params
      params.require(:language,:code)
    end
end
