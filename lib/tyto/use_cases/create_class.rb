module Tyto
  class CreateClassroom < UseCase
    def run(inputs)
      course = Tyto.db.get_course_from_name(inputs[:course_name])
      classroom = Tyto.db.create_classroom(teacher_id: inputs[:teacher_id],
                                           course_id:  course.id,
                                           name: inputs[:classroom_name])
      success :course => course, :classroom => classroom
    end
  end
end
