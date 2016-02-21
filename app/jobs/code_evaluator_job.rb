class CodeEvaluatorJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    puts "!!!!!!!!!!!!!!!!!!!"
    puts "!!!!!!!!!!!!!!!!!!!"
    puts "ñalkdjfasñlkfjañslkdfj"
    puts "!!!!!!!!!!!!!!!!!!!"
    puts "!!!!!!!!!!!!!!!!!!!"
  end
end
