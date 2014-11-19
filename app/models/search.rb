class Search
  include ActiveModel::Model
  attr_reader :term

  def initialize(term=nil)
    @term = term
  end

  def search_rant
    search_class(Rant, "text", "title")
  end

  def search_user_names
    search_column(User, "first_name", "last_name", "username").limit(10)
  end

  private

  def search_term
    @term
  end

  def search_column(class_name, term1=nil, term2=nil, term3=nil)
    class_name.where("#{term1} LIKE ? OR #{term2} LIKE ? OR #{term3} LIKE ?", "%#{search_term}%", "%#{search_term}%", "%#{search_term}%")
  end
end
