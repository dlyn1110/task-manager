class TasksController < ApplicationController

  get '/tasks'do
    redirect_if_not_logged_in
    erb :'tasks/tasks'
  end

  get '/tasks/new' do
    redirect_if_not_logged_in
    erb :'tasks/create'
  end

end
