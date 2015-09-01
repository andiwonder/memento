# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


user1= User.create(name: 'Swap', email:'skasliwal12@gmail.com',password: "123")
user2= User.create(name: 'Thompson', email:'t12@gmail.com',password: "123")
user3= User.create(name: 'David', email:'d12@gmail.com',password: "123")
user4= User.create(name: 'Neil', email:'n12@gmail.com',password: "123")



event1 = Event.create(title: 'jets', description: "vs giants" , logo:"1.jpeg",event_date:"8/1/2015")
event2 = Event.create(title: 'jets', description: "vs dolphins" , logo:"1.jpeg",event_date:"8/1/2015")
event3 = Event.create(title: 'jets', description: "vs patriots" , logo:"1.jpeg",event_date:"8/1/2015")
event4 = Event.create(title: 'jets', description: "vs cowboys" , logo:"1.jpeg",event_date:"8/1/2015")
event5 = Event.create(title: 'jets', description: "vs bills" , logo:"1.jpeg",event_date:"8/1/2015")


event1.users << user1