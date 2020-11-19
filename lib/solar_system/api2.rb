class SolarSystem::API
    attr_accessor :query

    def initialize(query)
        @query = query
    end

    def create_planet(query)        
        bodies = get_attributes["bodies"]
        bodies.each do |planet|
            if planet["englishName"] == query
        SolarSystem::Planet.new(planet["englishName"], planet["meanRadius"], planet["gravity"],
        planet["sideralRotation"], planet["sideralOrbit"])                     
    end
        end
    end

    def get_attributes
        # case query
        # when "Mercury"
        #     url = "https://api.le-systeme-solaire.net/rest/bodies/mercure"
        # when "Earth"
        #     url = "https://api.le-systeme-solaire.net/rest/bodies/terre"
        # when "Saturn"
        #     url = "https://api.le-systeme-solaire.net/rest/bodies/saturne"
        # else 
        #     url = "https://api.le-systeme-solaire.net/rest/bodies/#{query}"
        # end
        # uri = URI(url)
        # response = Net::HTTP.get(uri)
        # JSON.parse(response)

        url = "https://api.le-systeme-solaire.net/rest/bodies/"

        response = HTTParty.get(url)
        response.parsed_response
    end
    
end
