# == Schema Information
#
# Table name: submits
#
#  id           :integer          not null, primary key
#  code         :text
#  status       :integer
#  challenge_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  language     :string
#

class Submit < ActiveRecord::Base
  has_many :code_results, dependent: :destroy
  belongs_to :challenge

  validates :code, :status, :challenge_id, :language, presence: true

  enum status: [:pending, :evaluating, :passed, :not_passed, :timeout, :error]

  def evaluate!
    api_endpoint = ENV['API_ENPOINT'] || 'http://codejudge.io'
    submit_url = URI.join(api_endpoint,Rails.application.routes.url_helpers.api_worker_challenge_submit_path(self.challenge.id,self.id))
    result_url = URI.join(api_endpoint,Rails.application.routes.url_helpers.api_worker_challenge_submit_code_results_path(self.challenge.id,self.id))
    evaluator_url = URI.join(api_endpoint,Rails.application.routes.url_helpers.api_worker_evaluators_path)
    auth_token = ENV['WORKER_AUTH_TOKEN'] || User.worker.first.auth_token
    docker_image = ENV['DOCKER_IMAGE'] || 'codingjudge/evaluator'

    command = %Q(docker run -e "GET_SUBMIT_URL=#{submit_url}" -e "POST_CODE_RESULT_URL=#{result_url}" -e "AUTH_TOKEN=#{auth_token}" #{docker_image} bash -lc 'curl -H "Authorization: #{auth_token}" #{evaluator_url} -o e.rb ; ruby e.rb')
    puts command
    system command
  end

end
