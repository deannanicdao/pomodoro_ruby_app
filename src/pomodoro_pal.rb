

class Music
    attr_accessor :current_screen
    def initialize(current_screen)
        @current_screen == ""
        @pid = @pid
    end

    def play_music(file)
        @pid = spawn( 'afplay', file )
    end

    def switch_song
        Process.kill "TERM", @pid
    end

    def play_theme_music
        if @current_screen == "Menu"
            switch_song
            play_music('Sounds/menu_music_pomodoro_pal.mp3')
        elsif @current_theme.name == "Rest"
            switch_song
            play_music('Sounds/rest_music_pomodoro_pal.mp3')
        end
    end
end
# if condition1 == condition2
#     pid = fork{ system 'killall', 'afplay' }
#     pid = fork{ exec 'afplay', "Sounds/rest_music_pomodoro_pal.mp3" }
# elsif condition3 == condition4
#     pid = fork{ system 'killall', 'afplay' }
#     pid = fork{ exec 'afplay', "Sounds/menu_music_pomodoro_pal.mp3" }
# end

Music.new("Menu")