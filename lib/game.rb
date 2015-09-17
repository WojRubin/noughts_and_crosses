$:.unshift File.join(File.dirname(__FILE__), "..", "lib")
require 'state_machine/core_ext/class/state_machine'

class Game
  attr_accessor :option_who_first, :option_game_symbol, :matrix

  state_machine :state, :initial => :choose_who_first do

      event :start do
        transition all=> :choose_who_first
      end

      event :seted_who_first do
        transition :choose_who_first=> :choose_symbol
      end

      event :seted_symbol do
        transition :choose_symbol=> :start_game
      end

      event :to_user_move do
        transition [:start_game,:computer_move]=> :user_move
      end

      event :to_computer_move do
        transition [:start_game,:user_move]=> :computer_move
      end

      event :finish_game do
        transition all => :game_over
      end

    state :choose_who_first do
      def doing
        io = Io.new
        io.puts_message 'Choose who first. Type c-computer/u-user'
        @option_who_first = io.input :who_first
        self.seted_who_first if @option_who_first
        self.doing
      end
    end

    state :choose_symbol do
      def doing
        io = Io.new
        io.puts_message 'Choose Your symbol type o/x'
        @option_game_symbol = io.input :gamer_symbol
        self.seted_symbol if @option_game_symbol
        self.doing
      end
    end

    state :start_game do
      def doing
        io = Io.new
        io.puts_message 'Start Game'
        start_array = [[nil,nil,nil],[nil,nil,nil],[nil,nil,nil]]
        io.puts_screen start_array
        @matrix = Matrix.new(start_array, @option_game_symbol)
        @option_who_first == 'u' ? self.to_user_move  : self.to_computer_move
        self.doing
      end
    end

    state :user_move do
      def doing
        io = Io.new
        io.puts_message "Your move. Type together a-c and 1-3. Example: a1"
        move_string = io.input :move
        if move_string
          if @matrix.is_free_field?( move_string )
            @game_array = @matrix.add_user_move move_string
            io.puts_screen @game_array
            self.to_computer_move
            if @matrix.user_win?
              io.puts_message 'You win!'
              self.finish_game
            elsif !@matrix.is_free_move?
              io.puts_message 'Pat!'
              self.finish_game
            else
              self.to_computer_move
            end
          else
            io.puts_message "This field is not empty. Type a - z and 1 - 3. example: a1"
          end
        end
        self.doing
      end
    end

    state :computer_move do
      def doing
        io = Io.new
        io.puts_message 'Computer move'
        move_arr = @matrix.get_win_move || @matrix.get_blocking_move || @matrix.get_best_move || @matrix.get_random_free_move
        if move_arr
          @game_array = @matrix.add_move move_arr, 'computer'
          io.puts_screen @game_array
          if @matrix.computer_win?
            io.puts_message 'Computer win!'
            self.finish_game
          elsif !@matrix.is_free_move?
            io.puts_message 'Pat!'
            self.finish_game
          else
            self.to_user_move
          end
          self.doing
        else
          self.finish_game
          self.doing
        end
      end
    end

    state :game_over do
      def doing
        io = Io.new
        io.puts_message 'GAME OVER'
        io.puts_message 'Do You want play again?. Type y-yes/n-no'
        @again = io.input :play_again
        if @again == 'y'
          self.start 
          self.doing
        end
      end
    end
  end
end