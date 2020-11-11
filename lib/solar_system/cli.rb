require 'pry'
class SolarSystem::CLI

    @@planets = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]

    def call
        puts "Welcome to the Solar System!"
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
        
        puts "Which planet would you like to explore?"
        input = gets.strip
        if input.to_i.between?(1,8)
            select_planet(input)
        else
            invalid_input_2
            display_planets
        end
    end

    def select_planet(input)
        puts "Taking you to #{self.class.planets[input_to_index(input)]}!"
        index = self.input_to_index(input)
        query = self.class.planets[index]
        api = SolarSystem::API.new(query)
        api.create_planet
        SolarSystem::Planet.display_attributes
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
end