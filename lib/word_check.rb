module WordCheck
  class WordCheck

    SWEARWORDS = [
      "shit",
      "piss",
      "fuck",
      "cunt",
      "cocksucker",
      "tits",
      "bitch",
      "asshole",
      "crap"
    ]

    COMMONWORDS = [
      "the","be","to","of","and","a","in","that","have","i","it","for","not","on","with","he",
      "as","you","do","at","this","but","his","by","from","they","we","say","her","she","or","most",
      "an","will","my","one","all","would","there","their","what","so","up","out","if","about","us",
      "who","get","which","go","me","when","make","can","like","time","no","just","him","know",
      "take","people","into","year","your","good","some","could","them","see","other","than","day",
      "then","now","look","only","come","its","over","think","also","back","after","use","two",
      "how","our","work","first","well","way","even","new","want","because","any","these","give",
      "is","was","are","don't","i'm","got","u","has","it's","still","should","too","am",
      "had","you're","were","last","said","did","off","been","n","much","being"
    ]

    def self.count_for_user(word, line, user)
      (line.downcase.include?(word.downcase) && line.downcase.include?(user.downcase))? 1 : 0
    end

    def self.find_most_frequent(lines, iterator)
      huge_array, hash = [], Hash.new(0)
      lines.split('\n').each do |line|
        line = line.gsub(/(\d{2}:\d{2},\s\d{2}\s\w{3}\s-\s)([^:]+)/) {"#{$2.capitalize}"}
        line = line.gsub(/^.+:/,'')
        line = line.gsub(/\n/,"")
        line = line.gsub("<Media omitted>","media-omitted")
        split_up = line.split(" ") if line
        huge_array << split_up if split_up.length > 0
      end
      huge_array.flatten!
      huge_array.each { |word| hash[word] += 1 }
      array = hash.sort_by {|_key, value| value}.reverse[0..150]
      array = self.clear_common_words(array)
      iterator.set_most_frequent(array)
    end

    def self.clear_common_words(array)
      filtered_array = []
      array.each do |x|
        filtered_array << x unless WordCheck::COMMONWORDS.include?(x[0].downcase)
      end
      filtered_array[0,10].reverse
    end
  end
end