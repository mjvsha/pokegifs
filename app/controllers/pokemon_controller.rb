class PokemonController < ApplicationController

  def index

  end

  def show

    get_pokemon = HTTParty.get("http://pokeapi.co/api/v2/pokemon/#{params[:id]}/")
    parsed_response = JSON.parse(get_pokemon.body)
    @parsed_response= parsed_response
    @name = parsed_response["name"]
    @id = parsed_response["id"]
    @types = parsed_response["types"][0]["type"]["name"]

    get_giphy= HTTParty.get("https://api.giphy.com/v1/gifs/search?api_key=#{ENV['GIPHY_KEY']}&q=#{@name}&rating=g")
    giphy_body= JSON.parse(get_giphy.body)
    giphy_url = giphy_body["data"][0]["url"]

     render json: {
       "id":    @id,
       "name":  @name,
       "types": @types,
       "gif": giphy_url

     }

  end

end
