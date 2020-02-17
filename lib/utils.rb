module Utils
  module_function
  def titlecase(name = '')
    name.gsub('-','!').mb_chars.titlecase.to_s.gsub('!','-')
  end
end
