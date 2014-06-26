class MoviesController < ApplicationController
  before_action :add_movie, only: [:create, :show]

  def index
  	@movies = Movie.search_for(params[:q])
  end

  def show
  	@movie = Movie.find(params[:id])
  	# @movie = Movie.find_by_title(params[:id])
  end

  def new
  	@movie = Movie.new
  end

  def create
  	@movie = Movie.new(movie_params)
  	if @movie.save
  		redirect_to @movie
  	else
  		render "new"
  	end
  end

private
	def movie_params
		params.require("movie").permit(:title, :description, :year_released, :rating)
	end

  def add_movie
    @movie = Movie.create
      rescue ActiveRecord::RecordNotFound
    flash[:notice] = "Invalid movie"
    redirect_to root_path
  end
end
