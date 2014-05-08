# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Tyto.db.clear_everything

teacher1 = Tyto.db.create_teacher(username: "Brian Provost",
                              password: "password1",
                              email: "brian@teacher.com",
                              phone_number: "5120000000")

teacher2 = Tyto.db.create_teacher(username: "Parth Shah",
                              password: "password1",
                              email: "parth@teacher.com",
                              phone_number: "5121111111")

teacher3 = Tyto.db.create_teacher(username: "Gilbert Garza",
                              password: "password1",
                              email: "gilbert@teacher.com",
                              phone_number: "5122222222")

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
                                  phone_number: "5125555555")
course = Tyto.db.create_course(name: "algebra")

classroom1 = Tyto.db.create_classroom(teacher_id: teacher1.id,
                                      course_id:  course.id,
                                      name: "Period 1" )
classroom2 = Tyto.db.create_classroom(teacher_id: teacher1.id,
                                      course_id:  course.id,
                                      name: "Period 2" )
classroom3 = Tyto.db.create_classroom(teacher_id: teacher1.id,
                                      course_id:  course.id,
                                      name: "Period 3" )

Tyto.db.add_student_to_classroom(classroom_id: classroom1.id,
                                 student_id: student1.id)
Tyto.db.add_student_to_classroom(classroom_id: classroom1.id,
                                 student_id: student2.id)
Tyto.db.add_student_to_classroom(classroom_id: classroom1.id,
                                 student_id: student3.id)

Tyto.db.add_student_to_classroom(classroom_id: classroom2.id,
                                 student_id: student1.id)
Tyto.db.add_student_to_classroom(classroom_id: classroom2.id,
                                 student_id: student2.id)

Tyto.db.add_student_to_classroom(classroom_id: classroom3.id,
                                 student_id: student1.id)

chapter1 = Tyto.db.create_chapter(parent_id: course.id, name: "Chapter One")
chapter2 = Tyto.db.create_chapter(parent_id: course.id, name: "Chapter Two")

section1 = Tyto.db.create_chapter(parent_id: chapter1.id, name: "1.1")
section2 = Tyto.db.create_chapter(parent_id: chapter1.id, name: "1.2")
section3 = Tyto.db.create_chapter(parent_id: chapter1.id, name: "1.3")

section4 = Tyto.db.create_chapter(parent_id: chapter2.id, name: "2.1")
section5 = Tyto.db.create_chapter(parent_id: chapter2.id, name: "2.2")
section6 = Tyto.db.create_chapter(parent_id: chapter2.id, name: "2.3")

subtopics = [section1, section2, section3, section1, section2, section3]
subtopics.each do |x|
 Tyto.db.create_question(level: 1, question: "1+1",
                              answer: "2", chapter_id: x.id)
 Tyto.db.create_question(level: 1, question: "1+2",
                              answer: "3", chapter_id: x.id)
 Tyto.db.create_question(level: 1, question: "1+3",
                              answer: "4", chapter_id: x.id)
 Tyto.db.create_question(level: 1, question: "1+4",
                              answer: "5", chapter_id: x.id)
 Tyto.db.create_question(level: 1, question: "1+5",
                              answer: "6", chapter_id: x.id)
 Tyto.db.create_question(level: 1, question: "1+6",
                              answer: "7", chapter_id: x.id)
 Tyto.db.create_question(level: 1, question: "1+7",
                              answer: "8", chapter_id: x.id)
 Tyto.db.create_question(level: 1, question: "1+8",
                              answer: "9", chapter_id: x.id)
 Tyto.db.create_question(level: 1, question: "1+9",
                              answer: "10", chapter_id: x.id)

 Tyto.db.create_question(level: 2, question: "2+1",
                              answer: "3", chapter_id: x.id)
 Tyto.db.create_question(level: 2, question: "2+2",
                              answer: "4", chapter_id: x.id)
 Tyto.db.create_question(level: 2, question: "2+3",
                              answer: "5", chapter_id: x.id)
 Tyto.db.create_question(level: 2, question: "2+4",
                              answer: "6", chapter_id: x.id)
 Tyto.db.create_question(level: 2, question: "2+5",
                              answer: "7", chapter_id: x.id)
 Tyto.db.create_question(level: 2, question: "2+6",
                              answer: "8", chapter_id: x.id)
 Tyto.db.create_question(level: 2, question: "2+7",
                              answer: "9", chapter_id: x.id)
 Tyto.db.create_question(level: 2, question: "2+8",
                              answer: "10", chapter_id: x.id)
 Tyto.db.create_question(level: 2, question: "2+9",
                              answer: "11", chapter_id: x.id)

 Tyto.db.create_question(level: 3, question: "3+1",
                              answer: "4", chapter_id: x.id)
 Tyto.db.create_question(level: 3, question: "3+2",
                              answer: "5", chapter_id: x.id)
 Tyto.db.create_question(level: 3, question: "3+3",
                              answer: "6", chapter_id: x.id)
 Tyto.db.create_question(level: 3, question: "3+4",
                              answer: "7", chapter_id: x.id)
 Tyto.db.create_question(level: 3, question: "3+5",
                              answer: "8", chapter_id: x.id)
 Tyto.db.create_question(level: 3, question: "3+6",
                              answer: "9", chapter_id: x.id)
 Tyto.db.create_question(level: 3, question: "3+7",
                              answer: "10", chapter_id: x.id)
 Tyto.db.create_question(level: 3, question: "3+8",
                              answer: "11", chapter_id: x.id)
 Tyto.db.create_question(level: 3, question: "3+9",
                              answer: "12", chapter_id: x.id)

 Tyto.db.create_question(level: 4, question: "4+1",
                              answer: "5", chapter_id: x.id)
 Tyto.db.create_question(level: 4, question: "4+2",
                              answer: "6", chapter_id: x.id)
 Tyto.db.create_question(level: 4, question: "4+3",
                              answer: "7", chapter_id: x.id)
 Tyto.db.create_question(level: 4, question: "4+4",
                              answer: "8", chapter_id: x.id)
 Tyto.db.create_question(level: 4, question: "4+5",
                              answer: "9", chapter_id: x.id)
 Tyto.db.create_question(level: 4, question: "4+6",
                              answer: "10", chapter_id: x.id)
 Tyto.db.create_question(level: 4, question: "4+7",
                              answer: "11", chapter_id: x.id)
 Tyto.db.create_question(level: 4, question: "4+8",
                              answer: "12", chapter_id: x.id)
 Tyto.db.create_question(level: 4, question: "4+9",
                              answer: "13", chapter_id: x.id)
end



