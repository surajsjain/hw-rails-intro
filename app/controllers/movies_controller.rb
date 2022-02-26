class MoviesController < ApplicationController

    def show
      id = params[:id] # retrieve movie ID from URI route
      @movie = Movie.find(id) # look up movie by unique ID
      # will render app/views/movies/show.<extension> by default
    end
  
    def index
      @style_title = false
      @style_release = false
      
      @movies = Movie.all  
      
      what_to_order_by = params[:sort_by]
      
      
      if what_to_order_by == "title"
        @movies = @movies.order("title")
        @style_title = true
        
      elsif what_to_order_by == "release_date"
        @movies = @movies.order("release_date")
        @style_release = true
        
      end
      
      # Handling checkboxes
      @all_ratings = Movie.ratings
      @user_checks = Movie.user_checks

      if params[:commit]
        
        ratings_that_the_user_has_checked =  params[:ratings]
        @user_checks = Movie.update_checks(@user_checks, ratings_that_the_user_has_checked)
        @movies = @movies.with_ratings(ratings_that_the_user_has_checked)
        
      end
      
    end
  
    def new
      # default: render 'new' template
    end
  
    def create
      @movie = Movie.create!(movie_params)
      flash[:notice] = "#{@movie.title} was successfully created."
      redirect_to movies_path
    end
  
    def edit
      @movie = Movie.find params[:id]
    end
  
    def update
      @movie = Movie.find params[:id]
      @movie.update_attributes!(movie_params)
      flash[:notice] = "#{@movie.title} was successfully updated."
      redirect_to movie_path(@movie)
    end
  
    def destroy
      @movie = Movie.find(params[:id])
      @movie.destroy
      flash[:notice] = "Movie '#{@movie.title}' deleted."
      redirect_to movies_path
    end
  
    private
    # Making "internal" methods private is not required, but is a common practice.
    # This helps make clear which methods respond to requests, and which ones do not.
    def movie_params
      params.require(:movie).permit(:title, :rating, :description, :release_date)
    end
  end