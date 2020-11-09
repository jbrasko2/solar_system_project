class SolarSystem::CLI

    def call
        puts "Welcome to the Solar System!"
        list_planets
        menu
        goodbye
    end

    def list_planets
        puts "1. Mercury"
        puts "2. Venus"
        puts "3. Earth"
        puts "4. Mars"
        puts "5. Jupiter"
        puts "6. Saturn"
        puts "7. Uranus"
        puts "8. Neptune"
        puts "9. Pluto"
    end

    def menu
        puts "Which planet would you like to explore?"
        puts "Enter (1-9) or type 'exit' to quit."
        input = nil
        while input != "exit"
            input = gets.strip
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
            end
        end
    end

    def goodbye
        "Taking you home..."
    end
end