class User
  attr_accessor :name, :email,:first_name, :last_name

  def initialize(attributes = {})
    @name  = attributes[:name]
    @email = attributes[:email]
    @first_name = attributes[:first_name]
    @last_name = attributes[:last_name]
  end

  def full_name
    "#{@first_name} #{@last_name}"
  end

  def formatted_email
    "#{full_name} <#{@email}>"
  end
  
  def alphabetical_name
      "#{@last_name}, #{@first_name}"
    end
    
end