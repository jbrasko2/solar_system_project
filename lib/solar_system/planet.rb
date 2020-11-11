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
        
    def self.display_attributes
        puts "What would you like to know?"
        puts "1. Radius"
        puts "2. Gravity"
        puts "3. Rotation"
        puts "4. Orbit"

        planet = self.all
        binding.pry

        input = gets.chomp
        case input
        when "1"
            puts "The radius of #{planet.englishName} is approximately #{planet.meanRadius} km wide!"
        when "2"
            puts "The gravitational pull of #{planet.englishName} is approximately #{planet.gravity} ms^2"
            puts "That is #{planet.gravity.to_i/9.807*100}% of Earth's gravity!"
        when "3"
            puts "#{planet.englishName} fully rotates once every #{planet.sideralRotation.to_i} Earth hours!"
        when "4"
            puts "#{planet.englishName} takes #{planet.sideralOrbit.to_i} Earth days to revolve around the sun!"
        else
            puts "BEEP-BOOP. Invalid entry... Please enter a number (1-4)."
            self.display_attributes
        end

    end



end
