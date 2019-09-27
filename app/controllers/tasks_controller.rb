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
       flash[:message] = "You have successfully added this new task."
       redirect to '/tasks'
       end
   end


   get '/tasks/:id' do
     if logged_in?
     @task = Task.find(params[:id])
     erb :'/tasks/show'
   else
     redirect to '/login'
   end
 end

 get '/tasks/:id/edit' do
    if logged_in?
      @task = Task.find_by(:id => params[:id])
      if current_user.id == @task.user_id
      erb :"tasks/edit"
    else
      flash[:notice] = "You are not authorized to edit this task."
      redirect to '/login'
     end
    end
  end

  patch '/tasks/:id' do
    if logged_in?
      @task = Task.find_by(:id => params[:id])
      @task.name = params[:name]
      if @task.save
        flash[:notice] = "Your Task Has Been Succesfully Updated"
        redirect to '/tasks'
      else
        redirect to "/tasks/#{@task.id}/edit"
      end
    end
  end

  delete '/tasks/:id/delete' do
    if logged_in?
      @task = Task.find_by(:id => params[:id])
      if current_user.id == @task.user_id
      @task.delete
      flash[:notice] = "Task successfully removed!"
      redirect to '/tasks'
      else
      redirect to '/login'
      end
    end
  end
end
