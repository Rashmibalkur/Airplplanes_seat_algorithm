require 'csv'
require 'byebug'

class Airplane

  def get_seat_map seat_set
    seat_set = seat_set.transpose
    @main_seat = []
    4.times do |no|
      main_array = []
        seat_set[0].each_with_index do |no_of_seats,index|
          s_array = []
          if no < seat_set[1][index]
            no_of_seats.times do |seat|
              print " O "
              s_array << "S"
            end
          else
             no_of_seats.times do |seat|
              print "   "
            end
          end
          print " || "
          main_array << s_array
        end
        puts ""
      @main_seat << main_array
    end
    puts "********SEAT ARRANGEMNETS******"
    print @main_seat
    return @main_seat
  end

  def get_seat_arrangements(no_of_passengers)
    no_of_passengers.times do |p|
      @main_seat,status = check_for_aisle(p)
      if !status
        @main_seat,status = check_for_window(p)
        if !status
          @main_seat,status = check_for_middle(p)
        end
      end
    end
      print @main_seat
  end

  def check_for_aisle(p)
    p = p + 1
    @main_seat.each_with_index do |seat_row,r_index|
      seat_row.each_with_index do |seat_block,b_index|
        seat_block.each_with_index do |seat,index|
          case b_index.to_s
          when "0"
            if seat_block[-1] == "S"
              @main_seat[r_index][b_index][-1] = p
            else
              next
            end
            return @main_seat, true
          when "1"
            if seat_block[0] == "S"
              @main_seat[r_index][b_index][0] = p
            elsif seat_block[-1] == "S"
              @main_seat[r_index][b_index][-1] = p
            else
              next
            end
              return @main_seat, true
          when "2"
            if seat_block[0] == "S"
              @main_seat[r_index][b_index][0] = p
              return @main_seat, true
            elsif seat_block[-1] == "S"
              @main_seat[r_index][b_index][-1] = p
              return @main_seat, true
            else
              next
            end
          when "3"
            if seat_block[0] == "S"
              @main_seat[r_index][b_index][0] = p
              return @main_seat, true
            else
              next
            end
          end
        end
      end
    end
    return @main_seat, false
  end

  def check_for_window(p)
    p = p + 1
    @main_seat.each_with_index do |seat_row,r_index|
      seat_row.each_with_index do |seat_block,b_index|
        seat_block.each_with_index do |seat,index|
          case b_index.to_s
          when "0"
            if seat_block[0] == "S"
              @main_seat[r_index][b_index][0] = p
            else
              next
            end
            return @main_seat, true
          when "1"
            next
          when "2"
            next
          when "3"
            if seat_block[-1] == "S"
              @main_seat[r_index][b_index][-1] = p
            else
              next
            end
              return @main_seat, true
          end
        end
      end
    end
    return @main_seat, true
  end

  def check_for_middle(p)
    p = p + 1
    @main_seat.each_with_index do |seat_row,r_index|
      seat_row.each_with_index do |seat_block,b_index|
        seat_block.each_with_index do |seat,index|
          empty = seat_block.collect{|x| a.index(x) if x != p }.compact
          empty.each do |z|
            @main_seat[r_index][b_index][z] = p
            return @main_seat, true
          end
        end
      end
    end
    return @main_seat, false
  end

end

a = Airplane.new
a.get_seat_map([ [3,2],  [4,3],  [2,3],  [3,4] ])
a.get_seat_arrangements(30)
