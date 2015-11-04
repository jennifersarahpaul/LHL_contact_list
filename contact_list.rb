require_relative 'contact_database'
require_relative 'contact'

# This should be the only file where you use puts and gets

def prompt_for_help
  puts "Type 'help'"
  user_typed_help = gets.chomp
  if user_typed_help == "help"
    commands_for_user
  else
    puts "You didn't type 'help'"
  end
end

def commands_for_user
  puts "Here is a list of available commands: new, list, show, find"
  user_command_choice = gets.chomp.downcase
  case user_command_choice
  when "new"  then new_contact
  when "list" then list_contacts
  when "show" then show_contact
  when "find" then find_contact
  else puts "You didn't type one of the command choices."
  end
end

def verify_email
  Contact.all.select do |contact|
    return "fail" if contact.email.match(@email)
  end
end

def new_contact
  puts "Type in your email address: "
  @email = gets.chomp.to_s
  if verify_email == "fail"
    puts "That email is already in the system."
  else
    puts "Type in your name: "
    @name = gets.chomp.to_s
    Contact.create(@name, @email, add_phone_numbers)
  end
end

def list_contacts
  Contact.all.each { |contact| puts contact }
  puts "-----\n#{ContactDatabase.database_size} records total"
end

def show_contact
  puts "Which ID number do you want to look up?"
  search_id = gets.chomp.to_i
  if search_id <= ContactDatabase.database_size
    puts Contact.show(search_id)
  else
    puts "This ID does not exist. Please choose an ID between 1 and #{ContactDatabase.database_size}."
  end
end

def find_contact
  puts "Specify a name: "
  term = gets.chomp.downcase.to_s
  Contact.find(term)
end

def add_phone_numbers
  phone_hash = {}
  extracting_phone_data = true

  while extracting_phone_data
    puts "Type in the type of phone number to add (mobile, home, work, etc.):" 
    phone_type = gets.chomp

    puts "What is your phone number?" 
    phone_number = gets.chomp

    phone_hash[phone_type] = phone_number

    puts "Do you want to add another phone number? yes/no"
    user_reply = gets.chomp.downcase

    extracting_phone_data = false if user_reply == "no"
  end
  phone_hash
end

prompt_for_help

