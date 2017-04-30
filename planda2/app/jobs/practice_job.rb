class PracticeJob < ApplicationJob
  queue_as :default



  def perform(*args)
    puts "Testing first job"
  end
end
