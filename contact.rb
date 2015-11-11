# require_relative 'contact_list'

class Contact

  require 'pg'
  require 'pry'
 
  attr_accessor :id, :name, :email, :phone

  def initialize(id, name, email, phone)
    @id = id
    @name = name
    @email = email
    @phone = phone
  end
 
  def to_s
    "#{id} - #{name}, #{email}" #, #{phone}"
  end
 
  ## Class Methods
  class << self

    def connection
      @@conn ||= PG.connect( 
        host: 'localhost', 
        dbname: 'contact', 
        user: 'development',
        password: 'development' 
      )
    end

    def create(firstname, lastname, email)
      sql = "INSERT INTO contacts(firstname, lastname, email) VALUES ($1, $2, $3)"
      connection.exec_params(sql, [firstname, lastname, email])
      # CODE FROM CONTACT LIST V.01
      # unique_id = ContactDatabase.assigns_new_id
      # ContactDatabase.adding_contact_to_array([unique_id, name, email, phone])
    end

    def all
      sql = "SELECT * FROM contacts"
      connection.exec_params(sql)
    end




      # list_of_contacts = ContactDatabase.loads_CSV_locally
      # list_of_contacts.map do |contact|
      #   Contact.new(contact[0], contact[1], contact[2], contact[3])
      # end
    # end
    
    def show(id)
      contact_found = nil
      sql = "SELECT * FROM contacts WHERE id = $1"
      connection.exec_params(sql, [id]) do |contact|
        contact.each do |row|
          contact_found = Contact.new(row["id"], 
            row["firstname"], 
            row["lastname"], 
            row["email"])
        end
      end
      contact_found
      # CODE FROM CONTACT LIST V.01
      # result = self.all.select { |contact| contact.id == id.to_s }
      # result.first
    end     
    
    def find(term)
    # CODE FROM CONTACT LIST V.01
    #   to_search = self.all.select do |contact|
    #     name_matched = contact.name.downcase.include?(term)
    #     email_matched = contact.email.downcase.include?(term)
    #     puts contact if name_matched || email_matched
    #   end
    # end
    end

  end
end

# c = Contact.create("Jennifer", "Tigner", "j@t.com");
# puts c
s = Contact.show(4)
puts s
# puts Contact.all 
