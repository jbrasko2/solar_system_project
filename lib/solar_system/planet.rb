class SolarSystem::Planet
    attr_accessor :englishName, :meanRadius, :gravity, :sideralRotation, :sideralOrbit

    @@all = []

    def initialize(englishName, meanRadius, gravity, sideralRotation, sideralOrbit)
        @englishName = englishName
        @meanRadius = meanRadius
        @gravity = gravity
        @sideralRotation = sideralRotation
        @sideralOrbit = sideralOrbit
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
