class CodeEvaluatorJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    # Awesome method goes here!
  end
end
