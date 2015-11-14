class Contact < ActiveRecord::Base
 
  validates :email, uniqueness: true
 
  def to_s
    "Contact ##{id}: #{firstname} #{lastname} (#{email})"
  end
end


