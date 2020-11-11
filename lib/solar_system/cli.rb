require 'pry'
class SolarSystem::CLI

    @@planets = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]

    def call
        puts ""
        puts "* ` * ` * ` * ` * ` * ` * ` * ` * ` * ` * ` * ` *".light_magenta
        puts "Greetings, Space Cadet! Welcome to the Solar System!".cyan
        puts ""
        puts "* ` * ` * ` * ` * ` * ` * ` * ` * ` * ` * ` * ` *".light_magenta
        puts "To explore planets, enter" + " 'planets'.".light_green
        puts "To return to your home planet, enter "+ "'abort'.".red
        menu
    end

    def menu
       input = gets.strip.downcase

       if input == "planets"
        display_planets
       elsif input == "abort"
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
        puts ""
        SolarSystem::CLI.planets.each_with_index {|planet, index| puts "#{index + 1}. #{planet}".cyan}
        
        puts "Which planet would you like to explore?" + " (1-8)".light_green
        input = gets.strip
        if input.to_i.between?(1,8)
            select_planet(input)
        else
            invalid_input_2
            self.display_planets
        end
    end

    def select_planet(input)
        puts ""
        puts "Setting coordinates to" +" #{self.class.planets[input_to_index(input)]}".cyan + "..."
        sleep 2
        puts "    ^"
        puts "   /" + " \\"
        puts "   |" + "U".cyan + "|"
        puts "   |" + "S".cyan + "|"
        puts "   |" + "A".cyan + "|"
        puts "  /"+ "___"+"\\"
        sleep 0.75
        puts "   VVV".red
        sleep 0.75
        puts "   VVV".red
        sleep 0.75
        puts "   VVV".red
        index = self.input_to_index(input)
        query = self.class.planets[index]
        api = SolarSystem::API.new(query)
        api.create_planet
        planet = SolarSystem::Planet.all[0]
        puts ""
        puts "You've arrived at " + "#{planet.englishName}".cyan + "!"
        sleep 2
        display_attributes
    end

    def goodbye
        puts "Taking you home..."
    end

    def  self.planets
        @@planets
    end

    def invalid_input
        puts ""
        puts "BEEP-BOOP. ".red + "Invalid entry... Please enter " + "'planets' ".light_green + "or " + "'abort'".red + "."
    end

    def invalid_input_2
        puts ""
        puts "BEEP-BOOP. ".red + "Invalid entry... Please enter a number" + " (1-8).".light_green
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

    def scan
        puts ""
        puts "Scanning...".red
        sleep 3
    end
        
    def display_attributes
        planet = SolarSystem::Planet.all[0]
        puts ""
        puts "What would you like to know?"
        sleep 0.5
        puts "1. " + "Size".light_magenta
        sleep 0.5
        puts "2. " + "Gravitational Pull".cyan
        sleep 0.5
        puts "3. " + "Day Length".light_green
        sleep 0.5
        puts "4. " + "Year Length".yellow



        input = gets.chomp
        case input
        when "1"
            scan
            puts ""
            puts "#{planet.englishName}".cyan + " is approximately " + "#{size_calc(planet.meanRadius).round}".light_green + " miles wide."
            puts "That's roughly " + "#{size_to_earth(size_calc(planet.meanRadius)).round(2)}x".light_green + " the size of Earth!"
            more_info(planet.englishName)
        when "2"
            scan
            puts ""
            puts "The gravitational pull of " + "#{planet.englishName}".cyan + " is approximately " + "#{planet.gravity.round(2)} m/s^2".light_green + "."
            puts "That is " + "#{gravity_calc(planet.gravity).round}%".light_green + " of Earth's gravity!"
            more_info(planet.englishName)
        when "3"
            scan
            puts ""
            puts "One day on " + "#{planet.englishName}".cyan + " is equal to roughly " + "#{planet.sideralRotation.round(half: :up).abs}".light_green + " Earth hours!"
            more_info(planet.englishName)
        when "4"
            scan
            puts ""
            puts "#{planet.englishName}".cyan + " takes " + "#{planet.sideralOrbit.to_i.round(2)}".light_green + " Earth days to revolve around the sun!"
            more_info(planet.englishName)
        else
            scan
            puts ""
            puts "BEEP-BOOP. ".cyan + "Invalid entry... Please enter a number" + " (1-4)".light_green + "."
            display_attributes
        end
    end

    def more_info(planet)
        puts ""
        puts ""
        sleep 3
        puts "Type " + "'more'".cyan + " to learn more about #{planet}."
        sleep 0.5
        puts "Type " + "'planets'".light_green + " to select a new planet."
        sleep 0.5
        puts "Type " + "'abort'".red + " to quit."
        input = gets.strip.downcase
        if input == "more"
            display_attributes
        elsif input == "planets"
            SolarSystem::Planet.destroy_all
            display_planets
        elsif input == "abort"
            goodbye
        else
            puts ""
            puts "BEEP-BOOP. ".red + "Invalid entry... Please enter a number " + "'more'".cyan + ", "+ "'planets'".light_green + " or " + "'abort'".red + "."
            more_info(planet)
        end
    end
end