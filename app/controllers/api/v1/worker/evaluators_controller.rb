class Api::V1::Worker::EvaluatorsController < ApplicationController
  before_action :authenticate_as_worker!, only: [:show]
  respond_to :json

  def show
    render file: 'evaluators/evaluator.rb'
  end

  private

  def code_result_params
    params.permit(:actual_output, :expected_output, :evaluator_status, :status, :submit_id, :test_case_id)
  end

end
