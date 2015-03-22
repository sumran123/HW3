# This file is app/controllers/movies_controller.rb
#RottenPotatoes' app/assets/stylesheets/application.css file.

class MoviesController < ApplicationController

  def index
    

    @all_ratings=Movie.all_rating;
    @ratings = {}
    if params[:ratings] != nil and session[:ratings] != nil
      @ratings = params[:ratings].keys
      session[:ratings]=@ratings
      #redirect_to(movies_path(:ratings => session[:ratings]))
    elsif params[:ratings] != nil and session[:ratings] == nil
      @ratings = params[:ratings].keys
      session[:ratings]=@ratings
    elsif params[:ratings] == nil and session[:ratings] != nil
      @ratings= session[:ratings]
    elsif params[:ratings] == nil and session[:ratings] == nil
      @ratings=@all_ratings
      #redirect_to(movies_path(:ratings => session[:ratings]))
    end
    session[:ratings]=@ratings
    par=params[:column_index]
    @title_=""
    @Release_date_=""
    if par=="title"
      @title_="hilite"
      @Release_date_=""
    elsif par=="Release_Date"
      @title_="";
      @Release_date_="hilite";
    end
    if par ==nil and session[:column_index] !=nil 
    par = session[:column_index]
    end
    session[:column_index]=par
      @movies = Movie.order(par).all
    if(@ratings.size()>0)
     @movies = Movie.find(:all,:conditions => {:rating => @ratings}, :order => par)
   end
  end
  
  def show
    id = params[:id] # retrieve movie ID from URI route

    @movie = Movie.find(id) # Look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
