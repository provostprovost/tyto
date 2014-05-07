module Tyto
  class AssignHomework < UseCase
    def run(inputs)
     classroom = Tyto.db.get_classroom_from_name(inputs[:classroom_name], inputs[:teacher_id])
     return failure(:classroom_not_found) if classroom == nil
     chapter = Tyto.db.get_chapter(inputs[:chapter_id])
     students = Tyto.db.get_students_in_classroom(classroom.id)
     return failure(:no_students_in_class) if students == nil
     assignments = []
     students.each do |x|
        assignment = Tyto.db.create_assignment(student_id: x.id,
                                          chapter_id: chapter.id,
                                          classroom_id: classroom.id,
                                          teacher_id: inputs[:teacher_id],
                                          assignment_size: inputs[:assignment_size])
        assignments.push(assignment)
     end
     success :assignments => assignments, :classroom => classroom, :chapter => chapter
   end
  end
end
