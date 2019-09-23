class TasksController < ApplicationController

  get '/tasks'do
      if logged_in?
        @tasks = current_user.tasks
        erb :'tasks/index'
      else
        redirect to '/signup'
     end
    end

end
