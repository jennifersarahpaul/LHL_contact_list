require 'pry'
require 'csv'
require_relative 'contact'

## TODO: Implement CSV reading/writing

class ContactDatabase

  class << self

    def loads_CSV_locally
      CSV.read('contacts.csv')
    end

    def assigns_new_id
      database = CSV.read('contacts.csv')
      (database.count < 1) ? 1 : 1 + database.count.to_i 
    end

    def database_size
      database = CSV.read('contacts.csv')
      database.count
    end

    def adding_contact_to_array(contact)
      CSV.open('contacts.csv', 'a') { |into_csv| into_csv << contact }
    end
  end
end
