module Tyto
  class AddStudentsToClass < UseCase
    def run(inputs)
     session = Tyto.db.get_session(inputs[:session_id])
     return failure(:session_not_found) if session==nil
     teacher_id = session.teacher_id
     classroom = Tyto.db.get_classroom(inputs[:classroom_id])
     return failure(:classroom_not_found) if classroom == nil
     return failure(:no_students_added) if inputs[:students]==[]
     return failure(:not_your_classroom) if classroom.teacher_id != teacher_id
     code = rand(100000...999999)
     invites = inputs[:students].map do |x|
        Tyto.db.create_invite(email: x,
                              teacher_id: teacher_id,
                              classroom_id: classroom.id,
                              code: code,
                              accepted: false)
     end

     invite_ids = invites.map {|x| x.id}

     success :classroom => classroom, :invites => invites, :invite_ids => invite_ids
   end
  end
end
