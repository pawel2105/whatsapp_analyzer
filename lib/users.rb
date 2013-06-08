module Users
  class Users
    def initialize
      @@users = []
      @@users_full_names = []
    end

    def return_all_from_each_line(lines)
      lines.each do |line|
        user = line.dup
      	user.gsub!(/^\D.+/,"") # remove anything that isn't the start of a message
        user.gsub!(/(\d{2}:\d{2},\s\d{2}\s\w{3}\s-\s)([^:]+)/) {"#{$2.capitalize}"}
        user.gsub!(/:.*$/,"")
        @@users_full_names << user
        user = user.gsub(/\s.+/,"")
        user if user.length > 0
        @@users << user
      end
      clean_user_array
    end

    def self.all_users
      @@users
    end

    def self.all_users_full_names
      @@users_full_names.flatten!
      @@users_full_names.compact!
      @@users_full_names.uniq!
      @@users_full_names.select! { |u| u if u.length > 0}
      @@users_full_names
    end

    def clean_user_array
      @@users.flatten!
      @@users.compact!
      @@users.uniq!
      @@users.select! { |u| u if u.length > 0}
    end
  end
end