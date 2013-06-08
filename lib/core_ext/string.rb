class String
  def clean_name
    self.gsub!("- ","")
  end
end