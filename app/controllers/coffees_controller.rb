class CoffeesController < ApplicationController

  get '/coffees' do
    if logged_in?
      @coffees = Coffee.all
      erb :'/coffees/coffees'
    else
      redirect to '/login'
    end
  end

  get '/coffees/new' do
    if !logged_in?
      redirect to '/login'
    else
      erb :'/coffees/create_coffee'
    end
  end

  post '/coffees' do
    if logged_in?
        if params[:name] == ""
          redirect to '/coffees/new'
        else
          @coffee = Coffee.create(name: params[:name], farm: params[:farm], pounds: params[:pounds])
          current_user.coffees << @coffee
          redirect to "/coffees/#{@coffee.id}"
        end
    else
        redirect to '/login'
    end
  end


  get '/coffees/:id' do
    if logged_in?
      @coffee = Coffee.find_by_id(params[:id])
      erb :'/coffees/show_coffee'
    else
      redirect to '/login'
    end
  end

  get '/coffees/:id/edit' do
    if logged_in?
      @coffee = Coffee.find_by_id(params[:id])
      if @coffee.user == current_user
        erb :'/coffees/edit_coffee'
      else
        redirect to '/coffees'
      end
    else
      redirect to '/login'
    end
  end

  patch '/coffees/:id' do
    if logged_in?
        if params[:name] == ""
          redirect to "/coffees/#{params[:id]}/edit"
        else
          @coffee = Coffee.find_by_id(params[:id])
          @coffee.update(name: params[:name], farm: params[:farm], pounds: params[:pounds])
          redirect to "/coffees/#{@coffee.id}"
        end
    else
        redirect to '/login'
    end
  end

  delete '/coffees/:id/delete' do
    if logged_in?
      @coffee = Coffee.find_by_id(params[:id])
      if @coffee.user_id == current_user.id
        @coffee.delete
        redirect to '/coffees'
      else
        redirect to '/coffees'
      end
    else
      redirect to '/login'
    end
  end

end
