require 'spec_helper'

shared_examples_for "a database" do
  let(:db) { described_class.new }
  before { db.clear_everything }

  describe 'Assignments' do
    before do
      @assignment = db.create_assignment( student_id: 1,
                                          chapter_id: 1,
                                          classroom_id: 1,
                                          teacher_id: 1,
                                          assignment_size: 10)
    end

    it "creates an assignment" do
      expect(@assignment).to be_a Tyto::Assignment
      expect(@assignment.student_id).to eq 1
      expect(@assignment.chapter_id).to eq 1
      expect(@assignment.classroom_id).to eq 1
      expect(@assignment.id).to_not be nil
    end

    it "gets an assignment" do
      retrieved_assignment = db.get_assignment(@assignment.id)
      expect(retrieved_assignment.id).to eq(@assignment.id)
      expect(retrieved_assignment.student_id).to eq(@assignment.student_id)
      expect(retrieved_assignment.classroom_id).to eq(@assignment.classroom_id)
      expect(retrieved_assignment.teacher_id).to eq(@assignment.teacher_id)
      expect(retrieved_assignment.assignment_size).to eq(@assignment.assignment_size)
    end

    it "edits an assignment" do
      db.edit_assignment( id: @assignment.id,
                          assignment_size: 15,
                          classroom_id: 4,
                          teacher_id: 9)
      edited_assignment = db.get_assignment(@assignment.id)
      expect(edited_assignment.id).to eq @assignment.id
      expect(edited_assignment.assignment_size).to eq 15
    end
  end


   describe 'Chapter' do
    before do
      @chapter = db.create_chapter(parent_id: 1, name: "Cool Chapter")
    end

    it "creates a chapter" do
      expect(@chapter).to be_a Tyto::Chapter
      expect(@chapter.name).to eq "Cool Chapter"
    end

    it "gets a chapter" do
      retrieved_chapter = db.get_chapter(@chapter.id)
      expect(retrieved_chapter.id).to eq @chapter.id
      expect(retrieved_chapter.name).to eq @chapter.name
      expect(retrieved_chapter.parent_id).to eq @chapter.parent_id
    end

    it "edits a chapter" do
      db.edit_chapter(  id: @chapter.id,
                        name: "Edited Chapter" )
      edited_chapter = db.get_chapter(@chapter.id)
      expect(edited_chapter.id).to eq @chapter.id
      expect(edited_chapter.name).to eq "Edited Chapter"
    end
  end


  describe 'Classroom' do
    before do
      @classroom = db.create_classroom( teacher_id: 55,
                                        course_id:  66,
                                        name: "Period 1" )
    end

    it "creates a classroom" do
      expect(@classroom).to be_a Tyto::Classroom
      expect(@classroom.teacher_id).to eq 55
      expect(@classroom.course_id).to eq 66
      expect(@classroom.name).to eq "Period 1"
    end

    it "gets a classroom" do
      retrieved_classroom = db.get_classroom(@classroom.id)
      expect(retrieved_classroom.id).to eq @classroom.id
      expect(retrieved_classroom.teacher_id).to eq @classroom.teacher_id
      expect(retrieved_classroom.course_id).to eq @classroom.course_id
      expect(retrieved_classroom.name).to eq "Period 1"
    end

    it "can add a student to a classroom" do
      pair = db.add_student_to_classroom(classroom_id: @classroom.id, student_id: 55)
      expect(pair.student_id).to eq 55
      expect(pair.classroom_id).to eq @classroom.id
    end

    it "can get all students from a classroom" do
      student1 = db.create_student({username: "parth",
                                    password: "1234",
                                    email: "pss8te@virginia.edu",
                                    phone_number: '7576507728'})
      student2 = db.create_student({username: "brian",
                                    password: "1234",
                                    email: "asdfasd@virginia.edu",
                                    phone_number: '0987654321'})
      student3 = db.create_student({username: "gilbert",
                                    password: "1234",
                                    email: "psffffffs8te@virginia.edu",
                                    phone_number: '1234567890'})

      new_classroom = db.create_classroom( teacher_id: 4, course_id: 72 )
      db.add_student_to_classroom(classroom_id: new_classroom.id,
                                  student_id: student1.id )
      db.add_student_to_classroom(classroom_id: new_classroom.id,
                                  student_id: student2.id )
      db.add_student_to_classroom(classroom_id: new_classroom.id,
                                  student_id: student3.id )

      all_students = db.get_students_in_classroom(new_classroom.id)

      # expect(all_students).to be_a Array
      expect(all_students.first).to be_a Tyto::Student
      expect(all_students.first.id).to eq student1.id
    end
  end


  describe 'Courses' do
    before do
      @course = db.create_course(name: "algebra")
      @course_two = db.create_course(name: "science")
    end
    it "creates a course" do
      expect(@course.name).to eq("algebra")
    end

    it "gets a course" do
      course = db.get_course(@course.id)
      expect(course.name).to eq("algebra")
    end

    it "edits a course" do
      course = db.edit_course(id: @course.id, name: "algebra2")
      expect(course.id).to eq(@course.id)
      expect(course.name).to eq("algebra2")
    end

    it "gets a course from name" do
      course = db.get_course_from_name("science")
      expect(course.id).to eq(@course_two.id)
      expect(course.name).to eq(@course_two.name)
    end
  end


  describe 'Questions' do
    before do
      @question = db.create_question( level: 5, question: "2+2",
                                      answer: "4", chapter_id: 5)
    end
    it "creates a question" do
      expect(@question.level).to eq(5)
      expect(@question.question).to eq("2+2")
      expect(@question.answer).to eq("4")
      expect(@question.chapter_id).to eq(5)
    end

    it "gets a question" do
      question = db.get_question(@question.id)
      expect(question.level).to eq(5)
      expect(question.question).to eq("2+2")
      expect(question.answer).to eq("4")
      expect(question.chapter_id).to eq(5)
    end

    it "edits a question" do
      question = db.edit_question(id: @question.id, chapter_id: 10)
      expect(question.chapter_id).to eq(10)
      expect(question.level).to eq(5)
    end
  end


  describe 'Responses' do
    before do
      @student = db.create_student({username: "Brian",
                                    password: "1234",
                                    email: "fake@email.com",
                                    phone_number: '1234567890'})
      @chapter = db.create_chapter(parent_id: 1, name: "Cool Chapter")
      @question = db.create_question( level: 2, question: "2+2",
                                      answer: "4", chapter_id: @chapter.id)
      @question_two = db.create_question( level: 1, question: "1+1",
                                      answer: "2", chapter_id: @chapter.id)
      @question_three = db.create_question( level: 3, question: "3+3",
                                      answer: "6", chapter_id: @chapter.id)
      @question_four = db.create_question( level: 1, question: "4+4",
                                      answer: "8", chapter_id: @chapter.id)
      @question_five = db.create_question( level: 2, question: "5+5",
                                      answer: "10", chapter_id: @chapter.id)
      @question_six = db.create_question( level: 3, question: "6+6",
                                      answer: "12", chapter_id: @chapter.id)
      @question_seven = db.create_question( level: 4, question: "7+7",
                                      answer: "14", chapter_id: @chapter.id)
      @assignment = db.create_assignment( student_id: @student.id,
                                          chapter_id: @chapter.id,
                                          classroom_id: 1,
                                          teacher_id: 1,
                                          assignment_size: 20)
      @response = db.create_response( correct: true,
                                      question_id: @question.id,
                                      student_id: @student.id,
                                      assignment_id: @assignment.id,
                                      difficult: false,
                                      chapter_id: @chapter.id)

    end
    it "creates a response" do
      expect(@response.correct).to eq(true)
      expect(@response.question_id).to eq(@question.id)
      expect(@response.student_id).to eq(@student.id)
      expect(@response.assignment_id).to eq(@assignment.id)
      expect(@response.chapter_id).to eq(@chapter.id)
      expect(@response.proficiency).to eq(6)
    end

    it "gets a response" do
      response = db.get_response(@response.id)
      expect(response.correct).to eq(true)
      expect(@response.question_id).to eq(@question.id)
      expect(@response.student_id).to eq(@student.id)
      expect(@response.assignment_id).to eq(@assignment.id)
      expect(@response.chapter_id).to eq(@chapter.id)
      expect(@response.proficiency).to eq(6)

    end
      it 'increments proficieny for correct answers' do
        proficiency = db.get_response(@response.id).proficiency
        new_response = db.create_response(correct: true,
                                          question_id: @question.id,
                                          student_id: @student.id,
                                          assignment_id: @assignment.id,
                                          difficult: false)
        new_proficiency = db.get_proficiency(new_response.id)
        expect(new_proficiency).to be > proficiency
      end

      it 'decrements proficiency for incorrect answers' do
        proficiency = db.get_response(@response.id).proficiency
        new_response = db.create_response(correct: false,
                                          question_id: @question.id,
                                          student_id: @student.id,
                                          assignment_id: @assignment.id,
                                          difficult: false)
        new_proficiency = db.get_proficiency(new_response.id)
        expect(new_proficiency).to be < proficiency
      end

      it 'increments scores as expected' do
        level1 = db.create_question(level: 1, question: "2+2",
                                    answer: "4", chapter_id: @chapter.id)
        level2 = db.create_question(level: 2, question: "2+2",
                                    answer: "4", chapter_id: @chapter.id)
        level3 = db.create_question(level: 3, question: "2+2",
                                    answer: "4", chapter_id: @chapter.id)

        proficiency = db.get_response(@response.id).proficiency

        level1_correct = db.create_response( correct: true,
                                              question_id: level1.id,
                                              student_id: @student.id,
                                              assignment_id: @assignment.id,
                                              difficult: false)
        response1_prof = db.get_proficiency(level1_correct.id)
        expect(response1_prof).to eq proficiency + 12

        level2_correct = db.create_response( correct: true,
                                              question_id: level2.id,
                                              student_id: @student.id,
                                              assignment_id: @assignment.id,
                                              difficult: false)
        response2_prof = db.get_proficiency(level2_correct.id)
        expect(response2_prof).to eq proficiency + 6

        level3_correct = db.create_response( correct: true,
                                              question_id: level3.id,
                                              student_id: @student.id,
                                              assignment_id: @assignment.id,
                                              difficult: false)
        response3_prof = db.get_proficiency(level3_correct.id)
        expect(response3_prof).to eq proficiency + 4

        level1_incorrect = db.create_response(correct: false,
                                              question_id: level1.id,
                                              student_id: @student.id,
                                              assignment_id: @assignment.id,
                                              difficult: false)
        response4_prof = db.get_proficiency(level1_incorrect.id)
        expect(response4_prof).to eq proficiency - 6

        level2_incorrect = db.create_response(correct: false,
                                              question_id: level2.id,
                                              student_id: @student.id,
                                              assignment_id: @assignment.id,
                                              difficult: false)
        response5_prof = db.get_proficiency(level2_incorrect.id)
        expect(response5_prof).to eq proficiency - 3

        level3_incorrect = db.create_response(correct: false,
                                              question_id: level3.id,
                                              student_id: @student.id,
                                              assignment_id: @assignment.id,
                                              difficult: false)
        response6_prof = db.get_proficiency(level2_incorrect.id)
        expect(response6_prof).to eq proficiency - 3
      end
      it "gets the next question after you answer" do
        question = db.get_next_question(@response.proficiency, @student.id, @response.chapter_id)
        expect(question.level).to eq(1)
        response = db.create_response(correct: true,
                                      question_id: question.id,
                                      student_id: @student.id,
                                      assignment_id: @assignment.id,
                                      difficult: false,
                                      chapter_id: @chapter.id)
        question = db.get_next_question(response.proficiency, @student.id, response.chapter_id)
        expect(question.level).to eq(1)
        response = db.create_response(correct: true,
                                      question_id: question.id,
                                      student_id: @student.id,
                                      assignment_id: @assignment.id,
                                      difficult: false,
                                      chapter_id: @chapter.id)
        question = db.get_next_question(response.proficiency, @student.id, response.chapter_id)
        expect(question).to eq(nil)
        question = db.get_next_question(45, @student.id, response.chapter_id)
        expect(question.level).to eq(2)
        question = db.get_next_question(65, @student.id, response.chapter_id)
        expect(question.level).to eq(3)
        question = db.get_next_question(90, @student.id, response.chapter_id)
        expect(question.level).to eq(4)
      end
  end


  describe 'Sessions' do
    before do
      @student_session = db.create_session(student_id: 5)
      @teacher_session = db.create_session(teacher_id: 6)
    end
    it "creates a student session" do
      expect(@student_session.student_id).to eq(5)
    end

    it "gets a student session" do
      student_session = db.get_session(@student_session.id)
      expect(@student_session.student_id).to eq(5)
    end

    it "creates a teacher session" do
      expect(@teacher_session.teacher_id).to eq(6)
    end

    it "gets a teacher session" do
      teacher_session = db.get_session(@teacher_session.id)
      expect(@teacher_session.teacher_id).to eq(6)
    end
  end

  describe 'Students' do
    before do
      @student = db.create_student({username: "parth",
                                    password: "1234",
                                    email: "pss8te@virginia.edu",
                                    phone_number: '7576507728'})
    end
    it "creates a student" do
      expect(@student.username).to eq("parth")
      expect(@student.correct_password?("1234")).to eq true
      expect(@student.email).to eq("pss8te@virginia.edu")
      expect(@student.phone_number).to eq("7576507728")
    end

    it "gets a student" do
      new_student = db.create_student(  username: "Cool guy",
                                        password: "5555",
                                        email: "fake@email.com",
                                        phone_number: '1234567890')
      expect(new_student.correct_password?("5555")).to eq true
      fetched_student = db.get_student(new_student.id)
      expect(fetched_student.username).to eq("Cool guy")
      expect(fetched_student.correct_password?("5555")).to eq true
      expect(fetched_student.email).to eq("fake@email.com")
      expect(fetched_student.phone_number).to eq("1234567890")
    end

    it "edits a student" do
      student = db.edit_student(:id => @student.id, username: "notparth")
      expect(student.username).to eq("notparth")
    end

    it "gets a student from email address" do
      student = db.get_student_from_email("pss8te@virginia.edu")
      expect(student.id).to eq @student.id
    end
  end

  describe 'Teachers' do
    before do
      @teacher = db.create_teacher({username: "parth",
                                    password: "1234",
                                    email: "pss8te@virginia.edu",
                                    phone_number: '7576507728'})
    end
    it "creates a teacher" do
      expect(@teacher.username).to eq("parth")
      expect(@teacher.correct_password?("1234")).to eq true
      expect(@teacher.email).to eq("pss8te@virginia.edu")
      expect(@teacher.phone_number).to eq("7576507728")
    end

    it "gets a teacher" do
      fetched_teacher = db.get_teacher(@teacher.id)
      expect(fetched_teacher.username).to eq("parth")
      expect(fetched_teacher.correct_password?("1234")).to eq true
      expect(fetched_teacher.email).to eq("pss8te@virginia.edu")
      expect(fetched_teacher.phone_number).to eq("7576507728")
    end

    it "edits a teacher" do
      teacher = db.edit_teacher(:id => @teacher.id, username: "coolerparth")
      expect(teacher.username).to eq("coolerparth")
    end

    it "gets a teacher from email address" do
      teacher = db.get_teacher_from_email("pss8te@virginia.edu")
      expect(teacher.id).to eq @teacher.id
    end
  end

  describe "Other Statistics" do
<<<<<<< HEAD
    it "gets longest streak for a user in a chapter" do
      student = db.create_student({username: "parth",
                                    password: "1234",
                                    email: "pss8te@virginia.edu",
                                    phone_number: '7576507728'})
      chapter = db.create_chapter(parent_id: 1, name: "Cool Chapter")
      question = db.create_question( level: 2, question: "2+2",
                                      answer: "4", chapter_id: chapter.id)
      assignment = db.create_assignment( student_id: student.id,
                                          chapter_id: chapter.id,
                                          classroom_id: 1,
                                          teacher_id: 1,
                                          assignment_size: 20)
      expect(db.get_longest_streak(student.id, chapter.id)).to eq(0)


      5.times do
        db.create_response(correct: true,
                                 question_id: question.id,
                                 student_id: student.id,
                                 assignment_id: assignment.id,
                                 difficult: false,
                                 chapter_id: chapter.id)
      end
      expect(db.get_longest_streak(student.id, chapter.id)).to eq(5)
      db.create_response(correct: false,
                                 question_id: question.id,
                                 student_id: student.id,
                                 assignment_id: assignment.id,
                                 difficult: false,
                                 chapter_id: chapter.id)
      expect(db.get_longest_streak(student.id, chapter.id)).to eq(5)
      6.times do
        db.create_response(correct: true,
                                 question_id: question.id,
                                 student_id: student.id,
                                 assignment_id: assignment.id,
                                 difficult: false,
                                 chapter_id: chapter.id)
      end
    expect(db.get_longest_streak(student.id, chapter.id)).to eq(6)
    end
=======
    describe "Current chapter streak" do
      before do
        @chapter = db.create_chapter(parent_id: 1, name: "Cool Chapter")
        @student = db.create_student( username: "Cool guy",
                                      password: "5555",
                                      email: "fake@email.com",
                                      phone_number: '1234567890')
        @assignment = db.create_assignment( student_id: @student.id,
                                            chapter_id: @chapter.id,
                                            classroom_id: 1,
                                            teacher_id: 1,
                                            assignment_size: 1000)
        @question = db.create_question( level: 5, question: "2+2",
                                        answer: "4", chapter_id: @chapter.id)
      end

      it "is 0 if no questions have been answered" do
        streak = db.current_chapter_streak(@student.id, @chapter.id)
        expect(streak).to eq 0
      end

      it "gets current streak for a user in a chapter" do
        5.times do
          db.create_response( correct: true,
                              question_id: @question.id,
                              student_id: @student.id,
                              assignment_id: @assignment.id,
                              difficult: false,
                              chapter_id: @chapter.id)
        end

        streak2 = db.current_chapter_streak(@student.id, @chapter.id)
        expect(streak2).to eq 5

        db.create_response( correct: false,
                            question_id: @question.id,
                            student_id: @student.id,
                            assignment_id: @assignment.id,
                            difficult: false,
                            chapter_id: @chapter.id)

        streak3 = db.current_chapter_streak(@student.id, @chapter.id)
        expect(streak3).to eq 0
      end

      it "resets current streak when a question is wrong" do
>>>>>>> 4a74b180164293ec23d822847232556ff97dddd8

      end
    end

    xit "gets longest streak for a user in a chapter" do
      longest_streak = db.longest_chapter_streak(student_id: @user.id, chapter_id: @chapter.id)
    end
  end
end
