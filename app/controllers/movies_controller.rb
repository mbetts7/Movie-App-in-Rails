class MoviesController < ApplicationController

  @@movie_db = [
          {"title"=>"The Matrix", "year"=>"1999", "imdbID"=>"tt0133093", "Type"=>"movie"},
          {"title"=>"The Matrix Reloaded", "year"=>"2003", "imdbID"=>"tt0234215", "Type"=>"movie"},
          {"title"=>"The Matrix Revolutions", "year"=>"2003", "imdbID"=>"tt0242653", "Type"=>"movie"}]

  # route: GET    /movies(.:format)
  def index
    @movies = @@movie_db

    respond_to do |format|
      format.html
      format.json { render :json => @@movie_db }
      format.xml { render :xml => @@movie_db.to_xml }
    end
  end
  # route: # GET    /movies/:id(.:format)
  def show  
    @movie = @@movie_db.find do |m|
      m["imdbID"] == params[:id]
    end
    if @movie.nil?
      flash.now[:message] = "Movie not found"
      # just so an object always exists.
      @movie = {}
    end
  end

  # route: GET    /movies/new(.:format)
  def new
  end

  # route: GET    /movies/:id/edit(.:format)
  def edit
    @movie = get_movie params[:id]
    # @movie = @@movie_db.find do |m|
    #   m["imdbID"] == params[:id]
    # end
    # if @movie.nil?
    #   flash.now[:message] = "Movie not found" if @movie.nil?
    #   @movie = {}
    # end
  end

  #route: # POST   /movies(.:format)
  def create
    # create new movie object from params
    movie = params.require(:movie).permit(:title, :year)
    movie["imdbID"] = rand(10000..100000000).to_s
    # add object to movie db
    @@movie_db << movie
    # show movie page
    # render :index
    redirect_to action: :index
  end

  # route: PATCH  /movies/:id(.:format)
  def update
    # @@movie_db.each do |movie|
    #   if movie["imdbID"] = params[:id]
    #     movie["title"] = params[:title]
    #     movie["year"] = params[:year]
    #   end
    # end
      
      @movie = get_movie params[:id]
      @@movie_db.delete @movie
      @movie["title"] = params[:movie][:title]
      @movie["year"] = params[:movie][:year]
      @@movie_db << @movie
      
      redirect_to movie_path(params[:id])
    #render will stay within same request
  end

  # route: DELETE /movies/:id(.:format)
  def destroy
      @movie = get_movie params[:id]
      @@movie_db.delete @movie
    # delete movie from movie_db
      redirect_to movies_path
    # redirect will send back to browser and tells browser to request second request and hit server again
  end

  def search
    query = params.require(:movie)
    response = Typhoeus.get("http://www.omdbapi.com/", params: {s: query})
    # result we get back is just a string, not an object.  so parse
    result = JSON.parse(response.body)
    if result["Search"] == nil
      redirect_to :index
    else
      @movies = result["Search"].sort_by { |movie| movie["Year"] }
      render :search_result
    end
  end

  private
  def get_movie movie_id
  the_movie = @@movie_db.find do |m|
      m["imdbID"] == movie_id
    end
    if the_movie.nil?
      flash.now[:message] = "Movie not found"
      the_movie = {}
    end
    the_movie
  end
end
