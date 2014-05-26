require 'chronic'
Tyto.db.clear_everything
teacher1 = Tyto.db.create_teacher(username: "Demo Teacher",
                              password: "password1",
                              email: "demo@teacher.com",
                              phone_number: "5120000000")

student1 = Tyto.db.create_student(username: "Benny Provost",
                              password: "password1",
                              email: "benny@student.com",
                              phone_number: "5123333333")
student2 = Tyto.db.create_student(username: "Evie Provost",
                                  password: "password1",
                                  email: "evie@student.com",
                                  phone_number: "5124444444")
student3 = Tyto.db.create_student(username: "Hasmukh Shah",
                                  password: "password1",
                                  email: "hasmukh@student.com",
                                  phone_number: "7576507728")
student4 = Tyto.db.create_student(username: "Demo Student",
                                  password: "password1",
                                  email: "demo@student.com",
                                  phone_number: "5125555555")
student5 = Tyto.db.create_student(username: "Eric Wyman",
                                  password: "password1",
                                  email: "a@student.com",
                                  phone_number: "5125555555")
student6 = Tyto.db.create_student(username: "John Smith",
                                  password: "password1",
                                  email: "b@student.com",
                                  phone_number: "5125555555")
student7 = Tyto.db.create_student(username: "Mike Simpson",
                                  password: "password1",
                                  email: "c@student.com",
                                  phone_number: "5125555555")
student8 = Tyto.db.create_student(username: "Phil White",
                                  password: "password1",
                                  email: "d@student.com",
                                  phone_number: "5125555555")
student9 = Tyto.db.create_student(username: "Elizabeth Gurley",
                                  password: "password1",
                                  email: "e@student.com",
                                  phone_number: "5125555555")
student10 = Tyto.db.create_student(username: "Kevin Durant",
                                  password: "password1",
                                  email: "f@student.com",
                                  phone_number: "5125555555")
student11 = Tyto.db.create_student(username: "Bruce Garter",
                                  password: "password1",
                                  email: "g@student.com",
                                  phone_number: "5125555555")
student12 = Tyto.db.create_student(username: "Jack Lewis",
                                  password: "password1",
                                  email: "h@student.com",
                                  phone_number: "5125555555")
student13 = Tyto.db.create_student(username: "Drew Smith",
                                  password: "password1",
                                  email: "i@student.com",
                                  phone_number: "5125555555")
student14 = Tyto.db.create_student(username: "Joe Garcia",
                                  password: "password1",
                                  email: "j@student.com",
                                  phone_number: "5125555555")
student15 = Tyto.db.create_student(username: "Kathy Castor",
                                  password: "password1",
                                  email: "k@student.com",
                                  phone_number: "5125555555")
student16 = Tyto.db.create_student(username: "Jim Himes",
                                  password: "password1",
                                  email: "l@student.com",
                                  phone_number: "5125555555")
student17 = Tyto.db.create_student(username: "Cory Gardner",
                                  password: "password1",
                                  email: "m@student.com",
                                  phone_number: "5125555555")
student18 = Tyto.db.create_student(username: "Scott Tipton",
                                  password: "password1",
                                  email: "n@student.com",
                                  phone_number: "5125555555")
student19 = Tyto.db.create_student(username: "Susan Davis",
                                  password: "password1",
                                  email: "o@student.com",
                                  phone_number: "5125555555")
student20 = Tyto.db.create_student(username: "Scott Peters",
                                  password: "password1",
                                  email: "p@student.com",
                                  phone_number: "5125555555")
student21 = Tyto.db.create_student(username: "Karen Bass",
                                  password: "password1",
                                  email: "q@student.com",
                                  phone_number: "5125555555")
student22 = Tyto.db.create_student(username: "Brad Sherman",
                                  password: "password1",
                                  email: "r@student.com",
                                  phone_number: "5125555555")
student23 = Tyto.db.create_student(username: "Julia Brown",
                                  password: "password1",
                                  email: "s@student.com",
                                  phone_number: "5125555555")
student24 = Tyto.db.create_student(username: "Mike Honda",
                                  password: "password1",
                                  email: "t@student.com",
                                  phone_number: "5125555555")
student25 = Tyto.db.create_student(username: "Jim Costa",
                                  password: "password1",
                                  email: "u@student.com",
                                  phone_number: "5125555555")
student26 = Tyto.db.create_student(username: "Barbara Lee",
                                  password: "password1",
                                  email: "v@student.com",
                                  phone_number: "5125555555")
student27 = Tyto.db.create_student(username: "Ami Bera",
                                  password: "password1",
                                  email: "w@student.com",
                                  phone_number: "5125555555")
student28 = Tyto.db.create_student(username: "Ed Pastor",
                                  password: "password1",
                                  email: "x@student.com",
                                  phone_number: "5125555555")
student29 = Tyto.db.create_student(username: "Don Young",
                                  password: "password1",
                                  email: "y@student.com",
                                  phone_number: "5125555555")
student30 = Tyto.db.create_student(username: "Martha Roby",
                                  password: "password1",
                                  email: "z@student.com",
                                  phone_number: "5125555555")


algebra = Tyto.db.create_course(name: "Algebra")
biology = Tyto.db.create_course(name: "Biology")
geometry = Tyto.db.create_course(name: "Geometry")
chemistry = Tyto.db.create_course(name: "Chemistry")

classroom1 = Tyto.db.create_classroom(teacher_id: teacher1.id,
                                      course_id:  algebra.id,
                                      name: "Algebra 1" )
classroom2 = Tyto.db.create_classroom(teacher_id: teacher1.id,
                                      course_id:  algebra.id,
                                      name: "Algebra 2" )
classroom3 = Tyto.db.create_classroom(teacher_id: teacher1.id,
                                      course_id:  biology.id,
                                      name: "Biology 1" )
classroom4 = Tyto.db.create_classroom(teacher_id: teacher1.id,
                                      course_id: biology.id,
                                      name: "Biology 2")

invite1 = Tyto.db.create_invite(email: "demo@student.com",
                                teacher_id: teacher1.id,
                                classroom_id: classroom1.id,
                                accepted: false)

invite2 = Tyto.db.create_invite(email: "demo@student.com",
                                teacher_id: teacher1.id,
                                classroom_id: classroom4.id,
                                accepted: false)
[student1, student2, student3, student5, student6, student7, student8, student9, student10, student11, student12, student13, student14, student15].each do |student|
  Tyto.db.add_student_to_classroom(classroom_id: classroom1.id,
                                 student_id: student.id
                                  )
  Tyto.db.add_student_to_classroom(classroom_id: classroom4.id,
                                 student_id: student.id
                                  )
end

[student16, student17, student18, student19, student20, student21, student22, student23, student24, student25, student26, student27, student28, student29, student30].each do |student|
  Tyto.db.add_student_to_classroom(classroom_id: classroom2.id,
                                 student_id: student.id
                                  )
  Tyto.db.add_student_to_classroom(classroom_id: classroom3.id,
                                 student_id: student.id
                                  )
end

