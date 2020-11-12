class SolarSystem::Planet
    attr_accessor :name, :radius, :gravity, :rotation, :orbit

    @@all = []

    def initialize(name, radius, gravity, rotation, orbit)
        @name = name
        @radius = radius
        @gravity = gravity
        @rotation = rotation
        @orbit = orbit
        save
    end

    def save
        @@all << self
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end
    
end
