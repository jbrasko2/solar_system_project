class SolarSystem::CLI

    @@planets = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]

    # diplay and command methods
    def call
        puts ""
        puts "* ` * ` * ` * ` * ` * ` * ` * ` * ` * ` * ` * ` *".light_magenta
        puts "Greetings, Space Cadet! Welcome to the " + "S".cyan + "o".green + "l".yellow + "a".red + "r ".light_magenta + "S".cyan + 
        "y".green + "s".yellow + "t".red + "e".light_magenta + "m".cyan + "!"
        puts ""
        puts "* ` * ` * ` * ` * ` * ` * ` * ` * ` * ` * ` * ` *".light_magenta
        puts "To explore planets, enter" + " 'planets'.".light_green
        puts "To return to your home planet, enter "+ "'abort'.".red
        menu
    end

    def menu
       input = gets.strip.downcase
       case input
       when "planets"
        select_planet
       when "abort"
        goodbye
       else
        invalid_input
        menu
       end
    end

    def select_planet
        puts ""
        self.class.planets.each_with_index {|planet, index| puts "#{index + 1}. #{planet}".cyan}
        
        puts "Which planet would you like to explore?" + " Enter" + " (1-8) ".light_green + "or " + "'abort'".red + " to quit"
        input = gets.strip
        if input.to_i.between?(1,8)
            send_planet(input)
        elsif input == "abort"
            goodbye
        else
            invalid_input_2
            select_planet
        end
    end

    def send_planet(input)
        puts ""
        puts "Setting coordinates to" +" #{self.class.planets[input.to_i - 1]}".cyan + "..."
        sleep 2
        rocket
        query = self.class.planets[input.to_i - 1]
        api = SolarSystem::API.new(query)
        api.create_planet
        planet = SolarSystem::Planet.all[0]
        puts ""
        puts "You've arrived at " + "#{planet.name}".cyan + "!"
        sleep 2
        select_attribute
    end
        
    def select_attribute
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
        sleep 0.5
        puts ""
        puts "Please enter " + "(1-4) ".light_green + "or " + "'abort' ".red + "to quit."


        input = gets.strip.downcase

        case input
        when "1"
            scan
            puts "#{planet.name}".cyan + " is approximately " + "#{size_calc(planet.radius).round}".light_green + " miles wide."
            puts "That's roughly " + "#{size_to_earth(size_calc(planet.radius)).round(2)}x".light_green + " the size of Earth!"
            more_info(planet.name)
        when "2"
            scan
            puts "The gravitational pull of " + "#{planet.name}".cyan + " is approximately " + "#{planet.gravity.round(2)} m/s^2".light_green + "."
            puts "That is " + "#{gravity_calc(planet.gravity).round}%".light_green + " of Earth's gravity!"
            more_info(planet.name)
        when "3"
            scan
            puts "One day on " + "#{planet.name}".cyan + " is equal to roughly " + "#{planet.rotation.round(half: :up).abs}".light_green + " Earth hours!"
            more_info(planet.name)
        when "4"
            scan
            puts "#{planet.name}".cyan + " takes " + "#{planet.orbit.to_i.round(2)}".light_green + " Earth days to revolve around the " + "sun".yellow + "!"
            more_info(planet.name)
        when "abort"
            goodbye
        else
            invalid_input_3
            select_attribute
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
        case input
        when "more"
            select_attribute
        when "planets"
            SolarSystem::Planet.destroy_all
            select_planet
        when "abort"
            goodbye
        else
            puts ""
            puts "BEEP-BOOP. ".red + "Invalid entry... Please enter " + "'more'".cyan + ", "+ "'planets'".light_green + " or " + "'abort'".red + "."
            more_info(planet)
        end
    end

    #animation
    def rocket
        puts "    ^"
        puts "   /" + " \\"
        puts "   |" + "U".cyan + "|"
        puts "   |" + "S".cyan + "|"
        puts "   |" + "A".cyan + "|"
        puts "  /"+ "___"+"\\"
        sleep 1.5
        puts "   VVV".red
        sleep 0.75
        puts "   VVV".red
        sleep 0.75
        puts "   VVV".red
        sleep 0.75
    end

    # storage
    def  self.planets
        @@planets
    end

    # calculations
    def input_to_index(input)
        input.to_i - 1
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
        puts ""
    end

    # conditions
    def invalid_input
        puts ""
        puts "BEEP-BOOP. ".red + "Invalid entry... Please enter " + "'planets' ".light_green + "or " + "'abort'".red + "."
    end

    def invalid_input_2
        puts ""
        puts "BEEP-BOOP. ".red + "Invalid entry... Please enter a number" + " (1-8).".light_green
    end

    def invalid_input_3
        puts ""
        puts "BEEP-BOOP. ".red + "Invalid entry... Please enter a number" + " (1-4)".light_green + "."
    end

    # quit
    def goodbye
        puts "Launching escape pod..."
    end

end