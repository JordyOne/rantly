class Search
  include ActiveModel::Model
  attr_reader :term

  def initialize(term=nil)
    @term = term
  end

  def search_rant
    search_columns(Rant, "text", "title").limit(10)
  end

  def search_user_names
    search_columns(User, "first_name", "last_name", "username").limit(10)
  end

  private

  def search_columns(table, term1=nil, term2=nil, term3=nil)
    if term3 != nil
      table.where("lower(#{term1}) LIKE ? OR lower(#{term2}) LIKE ? OR lower(#{term3}) LIKE ?",
                  "#{@term.downcase}%",
                  "#{@term.downcase}%",
                  "#{@term.downcase}%")
    else
      table.where("lower(#{term1}) LIKE ? OR lower(#{term2}) LIKE ?",
                  "%#{@term.downcase}%",
                  "%#{@term.downcase}%")
    end

  end
end
