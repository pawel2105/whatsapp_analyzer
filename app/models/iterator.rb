class Iterator
  include Users
  include WordCheck
  include Normalizer

  def initialize(file)
    @lines_unedited = file.read
    @cloned_lines = @lines_unedited.dup
    @lines = split_file_into_array(@cloned_lines)
    @users = Users.new.return_all_from_each_line(@lines)
    @num = 0
    get_all_stats
  end

  def split_file_into_array(string)
    array = []
    string.split("\n").each do |line|
      array << Engine.normalize(line) unless line == ""
    end
    array
  end

  def get_all_stats
    WordCheck.find_most_frequent(@lines_unedited, self)
  end

  def set_most_frequent(array)
    @most_frequent = array
  end

  def get_most_frequent
    @most_frequent.reverse
  end

  def check(word)
    @lines.each do |line|
      count(word, line)
    end
    @num
  end

  def check_for_words(words)
    count_array = []
    users = Users.all_users
    words.each do |word|
      users.each do |user|
        count_array << check_word_user_for_user(word,user)
      end
    end
    zip_results(count_array, users)
  end

  def zip_results(counts, users)
    array = []
    iterations = counts.size / users.size
    iterations.times do
      zippable = counts.slice!(0,users.size)
      array << users.zip(zippable)
    end
    array
  end

  def check_word_user_for_user(word, user)
    count_for_word = 0
    @lines.each do |line|
      count_for_word += WordCheck.count_for_user(word, line, user)
    end
    count_for_word
  end

  def get_swearwords
    @numbers_total = []
    users = Users.all_users
    users.each do |user|
      @swear_num = 0
      @lines.each do |line|
        count_curses_for_user(line, user)
      end
      @numbers_total << @swear_num
    end
    users.zip(@numbers_total).sort_by {|x| x[1]}.reverse
  end

  def check_each_user
    appearances, @counts = [], []
    users = Users.all_users_full_names
    @lines.each do |line|
      users.each do |user|
        appearances << count_messages_for_user(line,user)
      end
    end
    unique_users = appearances.uniq.compact
    unique_users.each do |user|
      @counts << appearances.select {|x| x == user }.size
    end
    unique_users.zip(@counts).sort_by {|x| x[1]}.reverse
  end

  def count(word, line)
    if line.downcase.include?(word.downcase)
      @num += 1
    end
  end

  def count_messages_for_user(line, user)
    if line.downcase.include?(" - #{user.downcase}: ")
      user
    end
  end

  def count_curses_for_user(line, user)
    WordCheck::SWEARWORDS.each do |swearword|
      if line.downcase.include?(swearword) && line.include?(user)
        @swear_num += 1
      end
    end
  end
end