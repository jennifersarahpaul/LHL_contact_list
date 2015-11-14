require_relative 'setup'

def commands_for_user
  while true
    puts "Here is a list of available commands: new, list, show, find, exit"
    user_command_choice = gets.chomp.downcase
    case user_command_choice
    when "new"  then new_contact
    when "list" then list_contacts
    when "show" then show_contact
    when "find" then find_contact
    when "exit" then return
    else puts "You didn't type one of the command choices."
    end
  end
end

def new_contact
  puts "Type in your email address:"
  email = gets.chomp
  puts "Type in your first name:"
  firstname = gets.chomp
  puts "Type in your last name:"
  lastname = gets.chomp
  Contact.create(firstname: firstname, lastname: lastname, email: email)
end

def list_contacts
  Contact.all.each { |contact| puts contact }
end

def show_contact
  puts "Which ID number do you want to look up?"
  search_id = gets.chomp.to_i
  puts (Contact.find(search_id) || "Contact not found")
end

def find_contact
  puts "Specify a name:"
  term = gets.chomp
  Contact.where(
    ["firstname LIKE '%' || :term || '%' OR
      lastname  LIKE '%' || :term || '%' OR
      email     LIKE '%' || :email || '%'", 
      { term: term, email: term.downcase }]
    ).each { |c| puts c }
end

commands_for_user