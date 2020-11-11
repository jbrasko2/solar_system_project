require 'pry'
class SolarSystem::CLI

    @@planets = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]

    def call
        puts "Hello Space Cadet! Welcome to the Solar System!"
        puts "To explore planets, enter 'planets'."
        puts "To leave the solar system, enter 'exit'."
        menu
    end

    def menu
       input = gets.strip.downcase

       if input == "planets"
        display_planets
       elsif input == "exit"
        goodbye
       else
        invalid_input
        menu
       end
    end

    def input_to_index(input)
        input.to_i - 1
    end

    def display_planets
        SolarSystem::CLI.planets.each_with_index {|planet, index| puts "#{index + 1}. #{planet}"}
        
        puts "Which planet would you like to explore? (1-8)"
        input = gets.strip
        if input.to_i.between?(1,8)
            select_planet(input)
        else
            invalid_input_2
            self.display_planets
        end
    end

    def select_planet(input)
        puts "Taking you to #{self.class.planets[input_to_index(input)]}!"
        index = self.input_to_index(input)
        query = self.class.planets[index]
        api = SolarSystem::API.new(query)
        api.create_planet
        display_attributes
    end

    def goodbye
        puts "Taking you home..."
    end

    def  self.planets
        @@planets
    end

    def invalid_input
        puts "BEEP-BOOP. Invalid entry... Please enter 'planets' or 'exit'."
    end

    def invalid_input_2
        puts "BEEP-BOOP. Invalid entry... Please enter a number (1-8)."
    end
    
    def size_calc(x)
        (x*2)*0.621371
    end

    def gravity_calc(x)
        (x/9.807)*100
    end

    def size_to_earth(x)
        x/7917.5
    end

        
    def display_attributes
        puts ""
        puts "What would you like to know?"
        puts "1. Size"
        puts "2. Gravitational Pull"
        puts "3. Day Length"
        puts "4. Year Length"

        planet = SolarSystem::Planet.all[0]

        input = gets.chomp
        case input
        when "1"
            puts ""
            puts "#{planet.englishName} is approximately #{size_calc(planet.meanRadius).round} miles wide."
            puts "That's roughly #{size_to_earth(size_calc(planet.meanRadius)).round(2)}x the size of Earth!"
            more_info(planet.englishName)
        when "2"
            puts ""
            puts "The gravitational pull of #{planet.englishName} is approximately #{planet.gravity.round(2)} m/s^2."
            puts "That is #{gravity_calc(planet.gravity).round}% of Earth's gravity!"
            more_info(planet.englishName)
        when "3"
            puts ""
            puts "One day on #{planet.englishName} is equal to roughly #{planet.sideralRotation.round(half: :up).abs} Earth hours!"
            more_info(planet.englishName)
        when "4"
            puts ""
            puts "#{planet.englishName} takes #{planet.sideralOrbit.to_i.round(2)} Earth days to revolve around the sun!"
            more_info(planet.englishName)
        else
            puts ""
            puts "BEEP-BOOP. Invalid entry... Please enter a number (1-4)."
            display_attributes
        end
    end

    def more_info(planet)
        puts ""
        puts ""
        puts "Type 'more' to learn more about #{planet}."
        puts "Type 'planets' to warp to a new planet."
        puts "Or type 'exit' to quit."
        input = gets.strip.downcase
        if input == "more"
            display_attributes
        elsif input == "planets"
            SolarSystem::Planet.destroy_all
            display_planets
        elsif input == "exit"
            goodbye
        else
            puts "BEEP-BOOP. Invalid entry... Please enter a number 'more', 'planets' or 'exit'."
            more_info(planet)
        end
    end
end