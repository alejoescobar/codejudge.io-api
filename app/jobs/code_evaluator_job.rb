class CodeEvaluatorJob < ActiveJob::Base
  queue_as :default

  def perform(submit)
    submit.evaluate!
  end
end
