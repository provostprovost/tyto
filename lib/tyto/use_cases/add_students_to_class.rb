module Tyto
  class AddStudentsToClass < UseCase
    def run(inputs)
     session = Tyto.db.get_session(inputs[:session_id])
     return failure(:session_not_found) if session==nil
     teacher_id = session.teacher_id
     classroom = Tyto.db.get_classroom(inputs[:classroom_id])
     return failure(:classroom_not_found) if classroom == nil
     return failure(:no_students_added) if inputs[:students]==nil
     success :students => students, :classroom => classroom
   end
  end
end
