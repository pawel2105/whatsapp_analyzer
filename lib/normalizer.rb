module Normalizer
  class Engine
    def self.normalize(line)
      if line.scan(/\d{2}:\d{2},\s\d{2}\s\w{3}\s-\s[^:].+/)[0] == line
        line
      else
        self.change_format(line)
      end
    end

    def self.change_format(line)
      copy = line.dup
      date = copy.match(/(\d+\/\d+\/\d+),\s(\d{2}:\d{2}:\d{2})\s(\w+:)\s([^:].+):(.+)/) { $1 }
      time = copy.match(/(\d+\/\d+\/\d+),\s(\d{2}:\d{2}:\d{2})\s(\w+:)\s([^:].+):(.+)/) { $2 }
      name = copy.match(/(\d+\/\d+\/\d+),\s(\d{2}:\d{2}:\d{2})\s(\w+:)\s([^:].+):(.+)/) { $4 }
      msg  = copy.match(/(\d+\/\d+\/\d+),\s(\d{2}:\d{2}:\d{2})\s(\w+:)\s([^:].+):(.+)/) { $5 }

      date_array = date.split("/") # Get an array like [21,12,13] from 12/12/13
      time_array = time.split(":") # Get an array like [15,04,3] from 15:04:3

      # Convert so that it's DateTime.new(yy,mm,dd)
      better_date = DateTime.new(date_array[2].to_i,
                                 date_array[0].to_i,
                                 date_array[1].to_i,
                                 time_array[0].to_i,
                                 time_array[1].to_i,
                                 time_array[2].to_i)



      better_date = better_date.strftime("%H:%M, %m %b")

      puts "#{better_date} - #{name}: #{msg}"

      return_value = "#{better_date} - #{name}: #{msg}"
    end
  end
end