require 'pry-debugger'
require 'chronic'
module Tyto
  class AssignHomework < UseCase
    def run(inputs)
     session = Tyto.db.get_session(inputs[:session_id].to_i)
     return failure(:session_not_found) if session==nil
     teacher_id = session.teacher_id
     classroom = Tyto.db.get_classroom(inputs[:classroom_id].to_i)
     return failure(:classroom_not_found) if classroom == nil
     chapter = Tyto.db.get_chapter(inputs[:chapter_id].to_i)
     students = Tyto.db.get_students_in_classroom(classroom.id)
     return failure(:no_students_in_class) if students == nil
     assignments = []
     deadline = nil
     deadline = Chronic.parse(inputs[:day] + " " + inputs[:time]) if inputs[:day] != nil
     students.each do |student|
        assignment = Tyto.db.create_assignment(student_id: student.id,
                                          chapter_id: chapter.id,
                                          classroom_id: classroom.id,
                                          teacher_id: teacher_id,
                                          assignment_size: inputs[:assignment_size].to_i,
                                          deadline: deadline
 )
        assignments.push(assignment)
        question = Tyto.db.get_next_question(0, student.id, chapter.id)
        Tyto.db.update_last_question(question_id: question.id,
                              student_id: student.id,
                              assignment_id: assignment.id)
     end
     success :assignments => assignments, :classroom => classroom, :chapter => chapter
   end
  end
end
