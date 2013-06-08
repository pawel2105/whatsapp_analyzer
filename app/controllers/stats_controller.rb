class StatsController < ApplicationController
  def new
  end

  def example
    @words = ["Nothing", "Everybody lies", "Shiny metal ass"]
    @chosen_words  = [[["John Snow", 0], ["Greg House", 5], ["John Snow", 13], ["Bender", 7], ["QI Master", 2],
                      ["Bilbo B.", 1], ["Machiavelli", 7], ["Arthur", 8], ["Fred", 1]],
                     [["John Snow", 0], ["Greg House", 120], ["John Snow", 33], ["Bender", 14], ["QI Master", 36],
                      ["Bilbo B.", 0], ["Machiavelli", 4], ["Arthur", 2], ["Fred", 21]],
                     [["John Snow", 0], ["Greg House", 9], ["John Snow", 0], ["Bender", 53], ["QI Master", 0],
                     ["Bilbo B.", 0], ["Machiavelli", 3], ["Arthur", 3], ["Fred", 18]]]
    @most_frequent = [["Bite", 177], ["Wildlings", 172], ["Suffering", 148], ["ignorance", 116], ["Lupus", 94],
                      ["Precious", 76], ["Mission", 58], ["Persuasion", 28], ["Stoic", 12], ["Xkcd", 7]]
    @msgs_per_user = [["John Snow", 1272], ["QI Master", 1148], ["Bilbo B.", 1094], ["ignorance", 816],
                      ["Greg House:", 588], ["Machiavelli", 476], ["Arthur", 177]]
    @swearwords    = ['Bender', 31],['Fred', 25],['Arthur', 20],['Greg House', 8]
  end

  def create
    if params[:chat_file] && params[:chat_file].content_type == "text/plain"
      uploaded_data = params[:chat_file]
      words = [params[:word_one],params[:word_two],params[:word_three]]

      @iterator = Iterator.new(uploaded_data)
      @chosen_words = @iterator.check_for_words(words)
      @swearwords = @iterator.get_swearwords
      @msgs_per_user = @iterator.check_each_user

      cookies["most_frequent"] = ActiveSupport::JSON.encode(@iterator.get_most_frequent)
      cookies["chosen_words"] = ActiveSupport::JSON.encode(@chosen_words)
      cookies["provided_words"] = ActiveSupport::JSON.encode(words)
      cookies["swearwords"] = ActiveSupport::JSON.encode(@swearwords)
      cookies["msgs_per_user"] = ActiveSupport::JSON.encode(@msgs_per_user)

      redirect_to results_path
    else
      flash[:error] = 'Please add a text file.'
      redirect_to :action => 'new'
    end
  end

  def results
    if cookies["most_frequent"] && cookies["chosen_words"]
      @most_frequent = ActiveSupport::JSON.decode(cookies["most_frequent"])
      @chosen_words = ActiveSupport::JSON.decode(cookies["chosen_words"])
      @words = ActiveSupport::JSON.decode(cookies["provided_words"])
      @swearwords = ActiveSupport::JSON.decode(cookies["swearwords"])
      @msgs_per_user = ActiveSupport::JSON.decode(cookies["msgs_per_user"])
    else
      flash[:error] = 'You need to upload a text file first.'
      redirect_to :action => 'new'
    end
  end
end