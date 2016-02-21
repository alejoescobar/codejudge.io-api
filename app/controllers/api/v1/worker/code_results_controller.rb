class Api::V1::Worker::CodeResultsController < ApplicationController
  before_action :authenticate_as_worker!, only: [:create]
  respond_to :json

  def create
    code_result = CodeResult.new(code_result_params)
    test_case = TestCase.find(params[:test_case_id])
    code_result.expected_output = test_case.output
    if params[:evaluator_status] == "ok"
      correct = code_result.expected_output == code_result.actual_output
      correct ? code_result.status = :passed : code_result.status = :wrong
    elsif params[:evaluator_status] == "timeout"
      code_result.status = :code_timeout
    else
      code_result.status = :wrong
      code_result.code_errors = params[:error]
    end
    if code_result.save
      render json: ["Good job!"], status: 200
    else
      render json: [errors: "Invalid email or password"], status: 422
    end
  end

  private

  def code_result_params
    params.permit(:actual_output, :expected_output, :evaluator_status, :status, :submit_id, :test_case_id)
  end

end
