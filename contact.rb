# require_relative 'contact_list'
require 'pg'
require 'pry'

class Contact
 
  attr_accessor :firstname, :lastname, :email

  def initialize(firstname, lastname, email)
    @firstname = firstname
    @lastname = lastname
    @email = email
  end
 
  def to_s
    "#{firstname} #{lastname}: #{email}"
  end
 
  ## Class Methods
  class << self

    def connection
      @@conn ||= PG.connect( 
        host: 'localhost', 
        dbname: 'contact', 
        user: 'development',
        password: 'development')
    end

    def create(firstname, lastname, email)
      sql = "INSERT INTO contacts(firstname, lastname, email) VALUES ($1, $2, $3)"
      connection.exec_params(sql, [firstname, lastname, email]) do
        test = Contact.new(firstname, lastname, email)
      end
    end

    def all
      sql = "SELECT * FROM contacts"
      list = []
      connection.exec_params(sql) do |contacts|
        contacts.each do |row|
          list << Contact.new( 
            row["firstname"], 
            row["lastname"], 
            row["email"]
          )
        end
      end
      list
    end
    
    def show(id)
      person = nil
      sql = "SELECT * FROM contacts WHERE id = $1"
      connection.exec_params(sql, [id]) do |contact|
        contact.each do |row|
          person = Contact.new( 
            row["firstname"], 
            row["lastname"], 
            row["email"]
          )
        end
      end
      person
    end     
    
    def find(key, term)
      person = nil
      sql = "SELECT * FROM contacts WHERE #{key} = $1"
      connection.exec_params(sql, [term]) do |contact|
        contact.each do |row|
          person = Contact.new(
            row["firstname"], 
            row["lastname"], 
            row["email"]
          )
        end
      end
      person
    end

    def find_by_firstname(name)
      Contact.find("firstname", name)
    end
    
    def find_by_lastname(name)
      Contact.find("lastname", name)
    end

    def find_by_email(email_address)
      Contact.find("email", email_address)
    end

  end
end

# create = Contact.create("Tom", "TA", "Tom@l.com");
# puts "Here is the newest contact:"
# puts create

# show = Contact.show(5)
# puts "Here is contact #5: "
# puts show

# f = Contact.find_by_firstname('Tom')
# puts f

# a = Contact.all
# puts "Here are all the PEOPLE"
# puts a


