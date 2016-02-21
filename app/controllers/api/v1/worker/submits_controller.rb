class Api::V1::Worker::SubmitsController < Api::V1::ApiController
  before_action :authenticate_as_worker!, only: [:show]
  respond_to :json

  def show
    challenge = Challenge.find(params[:challenge_id])
    submit = Submit.find(params[:id])
    test_cases_array = []
    challenge.test_cases.each do |test_case|
      test_cases_array.push({input: test_case.input, output: test_case.output, id: test_case.id})
    end
    respond_with({
      code: submit.code,
      language: submit.language,
      test_cases: test_cases_array
    })
  end

end
