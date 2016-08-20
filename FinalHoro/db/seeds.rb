# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(firstname:  "Sawarin",
            lastname: "Sodsangsook",
             timeofbirthhour: "18",
             timeofbirthmin: "30",
             date: "19",
             month: "10",
             year: "1994",
             birthdate: "พุธ",
             age: "22",
             moonyear: "จอ",
             phone: "0810000000",
             email: "calopc.canova@hotmail.com",
             username: "Admin1",
             password:              "thisisadmin",
             password_confirmation: "thisisadmin",
             admin: true)
