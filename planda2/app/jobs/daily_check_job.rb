class DailyCheckJob < ApplicationJob
  queue_as :default


  def perform(task)
     if task.frequency == daily
       task.cycles++
       if task.completeness == "finished"
         task.completed++
       end
       task.completeness="still need to start"
     end
  end
end

