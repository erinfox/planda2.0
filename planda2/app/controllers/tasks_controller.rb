class TasksController < ApplicationController

  before_action :authenticate_user!

  def index
    @tasks=Task.where(:user_id => current_user[:id])
    @dayTasks=@tasks.where(:frequency => "Daily")
    @weekTasks=@tasks.where(:frequency => "Weekly")
    @onceTasks=@tasks.where(:frequency => "Once")

    @dayTasksToDo=@dayTasks.where.not(:completeness_level =>"Done")
    @dayTasksDone=@dayTasks.where(:completeness_level =>"Done")
    @weekTasksToDo=@weekTasks.where.not(:completeness_level =>"Done")
    @weekTasksDone=@weekTasks.where(:completeness_level =>"Done")
    @onceTasksToDo=@onceTasks.where.not(:completeness_level =>"Done")
    @onceTasksDone=@onceTasks.where(:completeness_level =>"Done")
end

  def show
    @task=Task.find(params[:id])
    # @completionRate = @task[:completed]/@task[:cycles]
    @comments=Comment.where(task_id: params[:id])

    @compliment = Compliment.new
    @playlistArray = ["https://open.spotify.com/embed?uri=spotify:user:spotify:playlist:37i9dQZF1DWUNIrSzKgQbP","https://open.spotify.com/embed?uri=spotify:user:spotify:playlist:37i9dQZF1DWU0ScTcjJBdj","https://open.spotify.com/embed?uri=spotify:user:spotify:playlist:37i9dQZF1DX7KNKjOK0o75","https://open.spotify.com/embed?uri=spotify:user:spotify:playlist:37i9dQZF1DX6ziVCJnEm59","https://open.spotify.com/embed?uri=spotify:user:spotify:playlist:37i9dQZF1DWSqmBTGDYngZ","https://open.spotify.com/embed?uri=spotify:user:spotify:playlist:37i9dQZF1DX9XIFQuFvzM4","https://open.spotify.com/embed?uri=spotify:user:spotify:playlist:37i9dQZF1DX6z20IXmBjWI","https://open.spotify.com/embed?uri=spotify:user:spotify:playlist:37i9dQZF1DX82pCGH5USnM","https://open.spotify.com/embed?uri=spotify:user:sonymusic:playlist:6bfxfMIcYKN4ce6XQOxoqY","https://open.spotify.com/embed?uri=spotify:user:spotify:playlist:37i9dQZF1DWVu0D7Y8cYcs"]
    @randomPlaylist = @playlistArray.sample

    if @task.completeness_level == "Done"
        @compliment = Compliment.new
      end

  end

  def edit
    @task=Task.find(params[:id])
  end

  def update
    @task=Task.find(params[:id])
    @task.update(name: params[:name], frequency: params[:frequency], completeness_level: params[:completeness_level])
    redirect_to "/tasks"
  end

  def new
    @user = current_user
    @teams = @user.teams
  end

  def create
    @task = Task.new
    Task.create(name: params[:name],
                frequency: params[:frequency],
                completeness_level: params[:completeness_level],
                user_id: current_user[:id],team_id: params[:team_id])
    redirect_to "/tasks"
  end

  def destroy
    Comment.where(:task_id =>params[:id]).destroy_all
    Task.destroy(params[:id])
    redirect_to "/tasks/"
  end

end
