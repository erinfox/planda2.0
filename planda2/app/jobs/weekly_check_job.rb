class WeeklyCheckJob < ApplicationJob
  queue_as :default


  def perform(task)
   if task.frequency == weekly
     task.cycles++
     if task.completeness == "finished"
       task.completed++
     end
     task.completeness="still need to start"
   end

end
