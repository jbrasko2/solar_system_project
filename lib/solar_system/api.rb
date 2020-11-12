class SolarSystem::API
    attr_accessor :query

    def initialize(query)
        @query = query
    end

    def create_planet        
        planet = get_attributes
        SolarSystem::Planet.new(planet["englishName"], planet["meanRadius"], planet["gravity"],
        planet["sideralRotation"], planet["sideralOrbit"])
    end

    def get_attributes
        case query
        when "Mercury"
            url = "https://api.le-systeme-solaire.net/rest/bodies/mercure"
        when "Earth"
            url = "https://api.le-systeme-solaire.net/rest/bodies/terre"
        when "Saturn"
            url = "https://api.le-systeme-solaire.net/rest/bodies/saturne"
        else 
            url = "https://api.le-systeme-solaire.net/rest/bodies/#{query}"
        end
        get_uri(url)
    end
            
    def get_uri(url)
        uri = URI(url)
        response = Net::HTTP.get(uri)
        planet = JSON.parse(response)
    end
    
end
