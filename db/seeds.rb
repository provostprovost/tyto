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
                                  phone_number: "5555555555")
student4 = Tyto.db.create_student(username: "Demo Student",
                                  password: "password1",
                                  email: "demo@student.com",
                                  phone_number: "7576507728")
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




algebra = Tyto.db.create_course(name: "Math")
biology = Tyto.db.create_course(name: "Biology")
history = Tyto.db.create_course(name: "History")


classroom1 = Tyto.db.create_classroom(teacher_id: teacher1.id,
                                      course_id:  algebra.id,
                                      name: "P1 Math" )
classroom4 = Tyto.db.create_classroom(teacher_id: teacher1.id,
                                      course_id: biology.id,
                                      name: "P2 Biology")
classroom5 = Tyto.db.create_classroom(teacher_id: teacher1.id,
                                      course_id: history.id,
                                      name: "P3 History")

invite1 = Tyto.db.create_invite(email: "demo@student.com",
                                teacher_id: teacher1.id,
                                classroom_id: classroom5.id,
                                accepted: false)

[student1, student2, student3, student5, student6, student7, student8, student9, student10, student11, student12, student13, student14, student15, student16].each do |student|
  Tyto.db.add_student_to_classroom(classroom_id: classroom1.id,
                                 student_id: student.id
                                  )
  Tyto.db.add_student_to_classroom(classroom_id: classroom4.id,
                                 student_id: student.id
                                  )
end
 Tyto.db.add_student_to_classroom(classroom_id: classroom1.id,
                                 student_id: student4.id,
                                 text: true
                                  )
 Tyto.db.add_student_to_classroom(classroom_id: classroom4.id,
                                 student_id: student4.id,
                                 text: true
                                  )

chapter1 = Tyto.db.create_chapter(course_id: algebra.id, name: "Chapter 1")
          section_algebra_11 = Tyto.db.create_chapter(course_id: algebra.id, name: "Addition", parent_id: chapter1.id, subname: "1.1", video_url: 'https://www.youtube.com/watch?v=AuX7nPBqDts' )
          section_algebra_12 = Tyto.db.create_chapter(course_id: algebra.id, name: "Subtraction", parent_id: chapter1.id, subname: '1.2', video_url: 'https://www.youtube.com/watch?v=aNqG4ChKShI')
          section_algebra_13 = Tyto.db.create_chapter(course_id: algebra.id, name: "Multiplication", parent_id: chapter1.id, subname: '1.3', video_url: 'https://www.youtube.com/watch?v=mvOkMYCygps')
          section_algebra_14 = Tyto.db.create_chapter(course_id: algebra.id, name: "Division", parent_id: chapter1.id, subname: '1.4', video_url: 'https://www.youtube.com/watch?v=MTzTqvzWzm8')

chapter2 = Tyto.db.create_chapter(course_id: algebra.id, name: "Chapter 2")
          section_algebra_21 = Tyto.db.create_chapter(course_id: algebra.id, name: "Order of Operations", parent_id: chapter2.id, subname: "2.1", video_url: 'https://www.youtube.com/watch?v=GiSpzFKI5_w')
          section_algebra_22 = Tyto.db.create_chapter(course_id: algebra.id, name: "Place Value and Rounding", parent_id: chapter2.id, subname: "2.2", video_url: 'https://www.youtube.com/watch?v=jxA8MffVmPs')
          section_algebra_23 = Tyto.db.create_chapter(course_id: algebra.id, name: "Fractions and Decimals", parent_id: chapter2.id, subname: "2.3", video_url: 'https://www.youtube.com/watch?v=Gn2pdkvdbGQ')
          section_algebra_24 = Tyto.db.create_chapter(course_id: algebra.id, name: "Word Problems", parent_id: chapter2.id, subname: "2.4", video_url: 'https://www.youtube.com/watch?v=l4MgRPRoRhs')


chapter3 = Tyto.db.create_chapter(course_id: biology.id, name: "Chapter 1")
          section_biology_31 = Tyto.db.create_chapter(course_id: biology.id, name: "Biochemistry", parent_id: chapter3.id, subname: "1.1", video_url: 'https://www.youtube.com/watch?v=rD7DqDVrbV8' )
          section_biology_32 = Tyto.db.create_chapter(course_id: biology.id, name: "Cell Biology", parent_id: chapter3.id, subname: '1.2', video_url: 'https://www.youtube.com/watch?v=1Z9pqST72is')
          section_biology_33 = Tyto.db.create_chapter(course_id: biology.id, name: "Energy and Enzymes", parent_id: chapter3.id, subname: '1.3', video_url: 'https://www.youtube.com/watch?v=UhCmt1dCtXY')
          section_biology_34 = Tyto.db.create_chapter(course_id: biology.id, name: "Photosynthesis", parent_id: chapter3.id, subname: '1.4', video_url: 'https://www.youtube.com/watch?v=JUmT24R8CyA')
          section_biology_35 = Tyto.db.create_chapter(course_id: biology.id, name: "Cell Cycle and Mitosis", parent_id: chapter3.id, subname: '1.5', video_url: 'https://www.youtube.com/watch?v=2aVnN4RePyI')

question = Tyto.db.create_question(question: "____ + 6 = 100",
                        answer: "94",
                        level: 1,
                        chapter_id: section_algebra_11.id
                                    )

students = Tyto.db.get_students_in_classroom(classroom1.id)
students.each do |student|
assignment = Tyto.db.create_assignment(student_id: student.id,
                                          chapter_id: section_algebra_11.id,
                                          classroom_id: classroom1.id,
                                          teacher_id: teacher1.id,
                                          assignment_size: 25,
                                          deadline: Chronic.parse('tomorrow')
 )
Tyto.db.update_last_question(question_id: question.id,
                              student_id: student.id,
                              assignment_id: assignment.id)
assignment = Tyto.db.create_assignment(student_id: student.id,
                                          chapter_id: section_algebra_22.id,
                                          classroom_id: classroom1.id,
                                          teacher_id: teacher1.id,
                                          assignment_size: 20,
                                          deadline: Chronic.parse('next monday')
 )
assignment = Tyto.db.create_assignment(student_id: student.id,
                                          chapter_id: section_algebra_24.id,
                                          classroom_id: classroom1.id,
                                          teacher_id: teacher1.id,
                                          assignment_size: 15,
                                          deadline: Chronic.parse('next wednesday')
 )
end

students = Tyto.db.get_students_in_classroom(classroom4.id)
students.each do |student|
assignment = Tyto.db.create_assignment(student_id: student.id,
                                          chapter_id: section_biology_31.id,
                                          classroom_id: classroom4.id,
                                          teacher_id: teacher1.id,
                                          assignment_size: 15,
                                          deadline: Chronic.parse('tomorrow')
 )
assignment = Tyto.db.create_assignment(student_id: student.id,
                                          chapter_id: section_biology_32.id,
                                          classroom_id: classroom4.id,
                                          teacher_id: teacher1.id,
                                          assignment_size: 25,
                                          deadline: Chronic.parse('next monday')
 )
assignment = Tyto.db.create_assignment(student_id: student.id,
                                          chapter_id: section_biology_33.id,
                                          classroom_id: classroom4.id,
                                          teacher_id: teacher1.id,
                                          assignment_size: 30,
                                          deadline: Chronic.parse('next wednesday')
 )
end


Tyto.db.create_question(question: "20 + 39 = ____",
                        answer: "59",
                        level: 1,
                        chapter_id: section_algebra_11.id
                                    )
Tyto.db.create_question(question: "60 + ____ = 91",
                        answer: "31",
                        level: 1,
                        chapter_id: section_algebra_11.id
                                    )
Tyto.db.create_question(question: "94 + 7 = ____",
                        answer: "101",
                        level: 1,
                        chapter_id: section_algebra_11.id
                                    )
Tyto.db.create_question(question: "91 + ____ = 96",
                        answer: "5",
                        level: 1,
                        chapter_id: section_algebra_11.id
                                    )

Tyto.db.create_question(question: "3 + 41 + 9 = ____",
                        answer: "53",
                        level: 2,
                        chapter_id: section_algebra_11.id
                                    )
Tyto.db.create_question(question: "865 + 5 = ____",
                        answer: "870",
                        level: 2,
                        chapter_id: section_algebra_11.id
                                    )
Tyto.db.create_question(question: "50 + 8 + 7 + 50 = ____",
                        answer: "115",
                        level: 2,
                        chapter_id: section_algebra_11.id
                                    )
Tyto.db.create_question(question: "28 + 3 + 6 = ____",
                        answer: "37",
                        level: 2,
                        chapter_id: section_algebra_11.id
                                    )
Tyto.db.create_question(question: "15 + 4 + 9 = ____",
                        answer: "28",
                        level: 2,
                        chapter_id: section_algebra_11.id
                                    )

Tyto.db.create_question(question: "63 + 8 + 11 + 70 = ____",
                        answer: "152",
                        level: 3,
                        chapter_id: section_algebra_11.id
                                    )
Tyto.db.create_question(question: "90 + 3 + 6 + 36 = ____",
                        answer: "135",
                        level: 3,
                        chapter_id: section_algebra_11.id
                                    )
Tyto.db.create_question(question: "63 + 80 + 5 + 4 = ____",
                        answer: "152",
                        level: 3,
                        chapter_id: section_algebra_11.id
                                    )
Tyto.db.create_question(question: "22 + 10 + 3 + 70 = ____",
                        answer: "105",
                        level: 3,
                        chapter_id: section_algebra_11.id
                                    )
Tyto.db.create_question(question: "93 + 47 + 6 + 2 = ____",
                        answer: "148",
                        level: 3,
                        chapter_id: section_algebra_11.id
                                    )

Tyto.db.create_question(question: "2200 + 1305 = ____",
                        answer: "3505",
                        level: 4,
                        chapter_id: section_algebra_11.id
                                    )
Tyto.db.create_question(question: "3000 + 5859 = ____",
                        answer: "8859",
                        level: 4,
                        chapter_id: section_algebra_11.id
                                    )
Tyto.db.create_question(question: "6325 + 1089 = ____",
                        answer: "7414",
                        level: 4,
                        chapter_id: section_algebra_11.id
                                    )
Tyto.db.create_question(question: "5211 + 4864 = ____",
                        answer: "10075",
                        level: 4,
                        chapter_id: section_algebra_11.id
                                    )
Tyto.db.create_question(question: "4935 + 4260 = ____",
                        answer: "9195",
                        level: 4,
                        chapter_id: section_algebra_11.id
                                    )







