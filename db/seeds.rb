# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


teacher1 = @db.create_teacher(username: "Brian Provost",
                              password: "password1",
                              email: "brian@teacher.com",
                              phone_number: "5120000000")

teacher2 = @db.create_teacher(username: "Parth Shah",
                              password: "password1",
                              email: "parth@teacher.com",
                              phone_number: "5121111111")

teacher3 = @db.create_teacher(username: "Gilbert Garza",
                              password: "password1",
                              email: "gilbert@teacher.com",
                              phone_number: "5122222222")

student1 = @db.create_student(username: "Benny Provost",
                              password: "password1",
                              email: "benny@student.com",
                              phone_number: "5123333333")

student2 = @db.create_student(username: "Evie Provost",
                              password: "password1",
                              email: "evie@student.com",
                              phone_number: "5124444444")

student3 = @db.create_student(username: "Hasmukh Shah",
                              password: "password1",
                              email: "hasmukh@student.com",
                              phone_number: "5125555555")

student4 = @db.create_student(username: "Georgia Cross",
                              password: "password1",
                              email: "georgia@student.com",
                              phone_number: "5126666666")

student5 = @db.create_student(username: "Sandra Bullock Shah",
                              password: "password1",
                              email: "sandra@student.com",
                              phone_number: "5127777777")

