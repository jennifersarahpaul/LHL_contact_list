require 'pry'
require 'active_record'
require_relative 'contact'

ActiveRecord::Base.logger = Logger.new(STDOUT)

ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  host: 'localhost', 
  dbname: 'contact', 
  user: 'development',
  password: 'development'
)

puts 'CONNECTED TO ACTIVE RECORD'

ActiveRecord::Schema.define do
  # drop_table :contacts if ActiveRecord::Base.connection.table_exists?(:contacts)
  create_table :contacts do |t|
    t.column :firstname, :string
    t.column :lastname, :string
    t.column :email, :string
    t.timestamps null: false
  end unless ActiveRecord::Base.connection.table_exists?(:contacts)
end