class TasksController < ApplicationController

  get '/tasks'do
    redirect_if_not_logged_in
    erb :'tasks/tasks'
  end

  get '/tasks/new' do
    redirect_if_not_logged_in
    erb :'tasks/create'
  end

  post '/tasks' do
     redirect_if_not_logged_in
     if params[:name] == ""
       flash[:message] = "Please ensure all the fields are populated."
       redirect to '/tasks/new'
     else
       task = current_user.tasks.create(name: params[:name].capitalize)
       flash[:message] = "You have successfully added this new recipe."
       redirect to '/tasks'
       end
   end

end
