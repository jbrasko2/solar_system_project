class SolarSystem::CLI

    @@planets = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune", "Pluto"]

    def call
        puts "Welcome to the Solar System!"
        display_planets
        menu
        goodbye
    end

    def menu
        input = nil
        while input != "exit"
            puts "Which planet would you like to explore?"
            puts "Enter (1-9) for a planet, 'list' to list planets, or 'exit' to quit."
            
            input = gets.strip.downcase
            case input
            when "1"
                puts "More info on Mercury..."
            when "2"
                puts "More info on Venus..."
            when "3"
                puts "More info on Earth..."
            when "4"
                puts "More info on Mars..."
            when "5"
                puts "More info on Jupiter..."
            when "6"
                puts "More info on Saturn..."
            when "7"
                puts "More info on Uranus..."
            when "8"
                puts "More info on Neptune..."
            when "9"
                puts "More info on Pluto..."
            when "list"
                display_planets
            else
                puts "BEEP-BOOP. Does not compute...Please enter (1-9), 'list' or 'exit'."
            end
        end
    end

    def goodbye
        puts "Taking you home..."
    end

    def  self.planets
        @@planets
    end

    def display_planets
        SolarSystem::CLI.planets.each_with_index {|planet, index| puts "#{index + 1}. #{planet}"}
    end
end