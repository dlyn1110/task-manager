class UsersController < ApplicationController

  get '/signup' do
    erb :'users/signup'
  end


  post "/signup" do
   if params[:email] == "" || params[:password] == ""
     flash[:message] = "Please ensure all the fields are populated."
     erb :"/users/login"
   elsif
     User.find_by(:email => params[:email])
       flash[:message] = "You already have an account."
       erb :"users/login"
     else
       user = User.create(params)
       session[:user_id] = user.id
       redirect '/tasks'
     end
  end

   get "/login" do
      erb :"/users/login"
    end

    post "/login" do
     if params[:email] == "" || params[:password] == ""
       flash[:message] = "Please ensure all the fields are populated."
       erb :"/users/login"
     else
     user = User.find_by(:email => params[:email])
       if !user
         flash[:message] = "You do not have an account."
         erb :"users/signup"
       else
         if user && user.authenticate(params[:password])
           session[:user_id] = user.id
           redirect to "/tasks"
         else
           flash[:message] = "Your password is incorrect."
           erb :"/users/login"
         end
       end
     end
   end

   get '/logout' do
     if logged_in?
       session.destroy
       redirect to '/login'
   end
   end

 end
