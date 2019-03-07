# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(id:0, email:'default@mail.com', password: 'xyz', fname: 'default', 
        mname: 'default', lname: 'default', nat_id: 10000000, balance: 0, dl_no: 'zyz',
        mobile: 7000000000
    )
    
Car.create(id: 1, user_id: 0, model: 'default', transmission: 'default',
        reg_no: 'xyz', location: 'default', price: 0, insurance_no: 'zyz',
        seats: 5
    )