class Contact
 
  attr_accessor :id, :name, :email, :phone

  def initialize(id, name, email, phone)
    @id = id
    @name = name
    @email = email
    @phone = phone
  end
 
  def to_s
    "#{id} - #{name}, #{email}, #{phone}"
  end
 
  ## Class Methods
  class << self

    def create(name, email, phone)

      unique_id = ContactDatabase.assigns_new_id
      ContactDatabase.adding_contact_to_array([unique_id, name, email, phone])
    end

    def all
      list_of_contacts = ContactDatabase.loads_CSV_locally
      list_of_contacts.map do |contact|
        Contact.new(contact[0], contact[1], contact[2], contact[3])
      end
    end
    
    def show(id)
      result = self.all.select { |contact| contact.id == id.to_s }
      result = result.empty? ? nil : result.first
    end     
    
    def find(term)
      to_search = self.all.select do |contact|
        name_matched = contact.name.downcase.include?(term)
        email_matched = contact.email.downcase.include?(term)
        puts contact if name_matched || email_matched
      end
    end

  end
end





